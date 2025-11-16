# KRW AutoTrader

A FastAPI-based backend application for automated cryptocurrency trading with Korean won (KRW) support. Integrates with CCXT for exchange connectivity and uses Pydantic for data validation.

## Overview

**KRW AutoTrader** aims to provide:
- Automated trading strategies on KRW-paired cryptocurrencies
- Support for Korean exchanges (Upbit, Bithumb, etc.) via CCXT
- Robust REST API for trade management and configuration
- Early-stage foundation for multi-exchange trading

**Current Status:** Minimal viable structure with health check and basic Item model endpoints.

## Technology Stack

- **Framework:** FastAPI (async Python web framework)
- **Validation:** Pydantic (type-safe data models)
- **Exchange Integration:** CCXT (universal crypto exchange API)
- **Server:** Uvicorn (ASGI server)
- **Config:** python-dotenv (environment variables)
- **Testing:** pytest + FastAPI TestClient
- **Linting:** ruff (fast Python linter and formatter)

## Project Structure

```
krw-autotrader1118/
├── autotrader-app/
│   ├── backend/
│   │   ├── __init__.py          # Package marker
│   │   └── model.py             # FastAPI app + Pydantic models
│   └── requirements.txt          # Python dependencies
├── tests/
│   └── test_model.py            # HTTP endpoint tests
├── .github/
│   ├── copilot-instructions.md  # AI agent guidelines
│   └── workflows/
│       └── ci.yml               # GitHub Actions CI
├── CHANGELOG.md                 # Versioning and changes
├── pyproject.toml               # Project config + tool settings
└── README.md                    # This file
```

## Quick Start

### Prerequisites
- Python 3.12+ (recommended)
- pip (or poetry for dependency management)

### Setup

1. **Clone repository:**
   ```bash
   git clone https://github.com/haenna1118/krw-autotrader1118.git
   cd krw-autotrader1118
   ```

2. **Create virtual environment:**
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```

3. **Install dependencies:**
   ```bash
   pip install --upgrade pip setuptools wheel
   pip install -r autotrader-app/requirements.txt
   ```

### Running the Server

**Development mode (with auto-reload):**
```bash
cd autotrader-app
uvicorn backend.model:app --reload --host 127.0.0.1 --port 8000
```

**Production mode:**
```bash
cd autotrader-app
uvicorn backend.model:app --host 0.0.0.0 --port 8000 --workers 4
```

**Access:**
- Root endpoint: http://localhost:8000/
- API docs (Swagger): http://localhost:8000/docs
- API docs (ReDoc): http://localhost:8000/redoc

### API Endpoints

#### Health Check
```bash
curl http://localhost:8000/
# Response: {"Hello":"World"}
```

#### Create Item
```bash
curl -X POST http://localhost:8000/items/ \
  -H "Content-Type: application/json" \
  -d '{"name":"Bitcoin","description":"BTC/KRW","price":50000.00}'
# Response: {"name":"Bitcoin","description":"BTC/KRW","price":50000.0}
```

## Development

### Running Tests

```bash
cd /path/to/krw-autotrader1118
PYTHONPATH=autotrader-app pytest tests/ -v
```

**Or** with pyproject.toml (recommended):
```bash
pytest  # Runs with config from pyproject.toml
```

### Code Quality

**Linting with ruff:**
```bash
ruff check autotrader-app/ tests/
```

**Auto-format with ruff:**
```bash
ruff format autotrader-app/ tests/
```

**Type checking with mypy (optional):**
```bash
mypy autotrader-app/backend/ --ignore-missing-imports
```

### Continuous Integration

GitHub Actions automatically runs on every push and PR to `main`:
- **Tests:** pytest suite (`tests/`)
- **Lint:** ruff code style checks
- **Type:** mypy type checking (optional, doesn't block)

View CI status: https://github.com/haenna1118/krw-autotrader1118/actions

## Configuration

### Environment Variables

Create a `.env` file in `autotrader-app/` (never commit to git):

```dotenv
# Example: Exchange credentials (if needed)
EXCHANGE_NAME=upbit
API_KEY=your_api_key
API_SECRET=your_api_secret
```

Load with `python-dotenv`:
```python
from dotenv import load_dotenv
import os

load_dotenv()
api_key = os.getenv("API_KEY")
```

### Linting Config

Ruff rules are configured in `pyproject.toml` under `[tool.ruff]`:
- Line length: 100 characters
- Select: E, F, W (errors, warnings, and formatting)
- Ignore: E501 (line too long, handled by formatter)

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit changes: `git commit -m "feat: add your feature"`
4. Push to branch: `git push origin feature/your-feature`
5. Open a Pull Request

Commits must follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `ci:` CI/CD
- `chore:` Dependencies, maintenance
- `test:` Test additions/updates

## Next Steps

1. **Exchange Integration:** Add CCXT wrapper module (`backend/exchanges/`)
2. **Trade Models:** Expand Pydantic models for `Trade`, `Order`, `Position`
3. **Database:** Add SQLAlchemy for trade history (PostgreSQL recommended)
4. **Authentication:** Add FastAPI security (JWT tokens)
5. **Async:** Use async CCXT calls for performance
6. **Monitoring:** Add logging, metrics, and error tracking

## License

This project is provided as-is for educational and development purposes.

## Support

- **Issues:** https://github.com/haenna1118/krw-autotrader1118/issues
- **Discussions:** https://github.com/haenna1118/krw-autotrader1118/discussions
- **AI Agent:** See `.github/copilot-instructions.md` for developer AI guidelines

---

**Last Updated:** November 16, 2025
