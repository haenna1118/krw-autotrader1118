# Multi-stage Dockerfile for KRW AutoTrader
# Stage 1: Builder - compile dependencies
# Stage 2: Runtime - minimal production image

FROM python:3.12-slim as builder

# Set working directory
WORKDIR /build

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY autotrader-app/requirements.txt .

# Create virtual environment and install dependencies
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

# Stage 2: Runtime
FROM python:3.12-slim

# Set metadata
LABEL maintainer="haenna1118"
LABEL description="KRW AutoTrader - FastAPI-based crypto trading backend"
LABEL version="0.1.0"

# Set working directory
WORKDIR /app

# Create non-root user for security
RUN useradd -m -u 1000 trader && chown -R trader:trader /app

# Copy virtual environment from builder
COPY --from=builder /opt/venv /opt/venv

# Set environment
ENV PATH="/opt/venv/bin:$PATH" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PORT=8000

# Copy application code
COPY autotrader-app/ .

# Switch to non-root user
USER trader

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:${PORT}/')" || exit 1

# Expose port
EXPOSE ${PORT}

# Run application
CMD ["uvicorn", "backend.model:app", "--host", "0.0.0.0", "--port", "8000"]
