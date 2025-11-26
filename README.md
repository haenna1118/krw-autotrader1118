# KRW AutoTrader

A FastAPI-based backend application for automated cryptocurrency trading with Korean won (KRW) support. Integrates with CCXT for exchange connectivity and uses Pydantic for data validation.

## Overview

**KRW AutoTrader** aims to provide:

- Automated trading strategies on KRW-paired cryptocurrencies
- Support for Korean exchanges (Upbit, Bithumb, etc.) via CCXT
- Robust REST API for trade management and configuration
- Early-stage foundation for multi-exchange trading

**Current Status:** Minimal viable structure with a health check and a basic `Item` model endpoint.

## Technology Stack

- **Framework:** FastAPI (async Python web framework)
- **Validation:** Pydantic
- **Exchange Integration:** CCXT
- **Server:** Uvicorn
- **Config:** python-dotenv
- **Testing:** pytest + FastAPI TestClient
- **Linting:** ruff

## Project Structure

```text
krw-autotrader1118/
├── autotrader-app/
│   ├── backend/
│   │   ├── __init__.py
│   │   └── model.py
│   └── requirements.txt
├── tests/
│   └── test_model.py
├── .github/
│   └── copilot-instructions.md
├── pyproject.toml
└── README.md
```

## Quick Start

### Prerequisites

- Python 3.12+ (recommended)
- pip

### Setup

1. Clone the repository:

```bash
git clone https://github.com/haenna1118/krw-autotrader1118.git
cd krw-autotrader1118
```

2. Create and activate a virtual environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

3. Install dependencies:

```bash
pip install --upgrade pip setuptools wheel
pip install -r autotrader-app/requirements.txt
```

### Run the server (development)

```bash
cd autotrader-app
uvicorn backend.model:app --reload --host 127.0.0.1 --port 8000
```

Access the API docs at `http://localhost:8000/docs`.

## API Endpoints

### Health Check

```bash
curl http://localhost:8000/
# Response: {"Hello":"World"}
```

### Create Item

```bash
curl -X POST http://localhost:8000/items/ \
  -H "Content-Type: application/json" \
  -d '{"name":"Bitcoin","description":"BTC/KRW","price":50000.00}'
# Response: {"name":"Bitcoin","description":"BTC/KRW","price":50000.0}
```

## Development

Run tests:

```bash
cd /path/to/krw-autotrader1118
PYTHONPATH=autotrader-app pytest tests/ -v
```

Lint and format with `ruff`:

```bash
ruff check autotrader-app/ tests/
ruff format autotrader-app/ tests/
```

Type check (optional):

```bash
mypy autotrader-app/backend/ --ignore-missing-imports
```

## Exporting / Downloading the repository to your Desktop

A helper script `scripts/export_to_desktop.sh` is provided to create a ZIP of the repository and copy it to a Desktop location.

- If `HOST_DESKTOP_PATH` is set and writable the script copies the ZIP there (useful when the host filesystem is mounted into the container).
- Else if `REMOTE_USER_HOST` is set it attempts `scp` to copy the ZIP to `~/Desktop` on the remote host.
- Otherwise the script will create `/workspaces/krw-autotrader1118.zip` and print instructions for manual download.

Examples:

```bash
# Copy to a local host-mounted Desktop path (container must have write access)
HOST_DESKTOP_PATH=/home/you/Desktop ./scripts/export_to_desktop.sh

# Or copy to a remote machine via scp (optional port)
REMOTE_USER_HOST=user@1.2.3.4 REMOTE_PORT=2222 ./scripts/export_to_desktop.sh
```

## Contributing

1. Fork the repository
2. Create a branch: `git checkout -b feature/your-feature`
3. Commit and push
4. Open a Pull Request

Please follow Conventional Commits for messages.

## License

Provided as-is for educational and development purposes.

**Last Updated:** November 16, 2025

# KRW AutoTrader

A FastAPI-based backend application for automated cryptocurrency trading with Korean won (KRW) support. Integrates with CCXT for exchange connectivity and uses Pydantic for data validation.

## Overview

%0A# KRW AutoTrader%0A%0AA FastAPI-based backend application for automated cryptocurrency trading with Korean won (KRW) support. Integrates with CCXT for exchange connectivity and uses Pydantic for data validation.%0A%0A## Overview%0A%0A**KRW AutoTrader** aims to provide:%0A%0A- Automated trading strategies on KRW-paired cryptocurrencies%0A- Support for Korean exchanges (Upbit, Bithumb, etc.) via CCXT%0A- Robust REST API for trade management and configuration%0A- Early-stage foundation for multi-exchange trading%0A%0A**Current Status:** Minimal viable structure with health check and basic Item model endpoints.%0A%0A## Technology Stack%0A%0A- **Framework:** FastAPI (async Python web framework)%0A- **Validation:** Pydantic (type-safe data models)%0A- **Exchange Integration:** CCXT (universal crypto exchange API)%0A- **Server:** Uvicorn (ASGI server)%0A- **Config:** python-dotenv (environment variables)%0A- **Testing:** pytest + FastAPI TestClient%0A- **Linting:** ruff (fast Python linter and formatter)%0A%0A## Project Structure%0A%0A```text%0Akrw-autotrader1118/%0A├── autotrader-app/%0A│   ├── backend/%0A│   │   ├── __init__.py          # Package marker%0A│   │   └── model.py             # FastAPI app + Pydantic models%0A│   └── requirements.txt          # Python dependencies%0A├── tests/%0A│   └── test_model.py            # HTTP endpoint tests%0A├── .github/%0A│   ├── copilot-instructions.md  # AI agent guidelines%0A│   └── workflows/%0A│       └── ci.yml               # GitHub Actions CI%0A├── CHANGELOG.md                 # Versioning and changes%0A├── pyproject.toml               # Project config + tool settings%0A└── README.md                    # This file%0A```%0A%0A## Quick Start%0A%0A### Prerequisites%0A%0A- Python 3.12+ (recommended)%0A- pip (or poetry for dependency management)%0A%0A### Setup%0A%0A1. **Clone repository:**%0A%0A```bash%0Agit clone https://github.com/haenna1118/krw-autotrader1118.git%0Acd krw-autotrader1118%0A```%0A%0A2. **Create virtual environment:**%0A%0A```bash%0Apython3 -m venv .venv%0Asource .venv/bin/activate  # On Windows: .venv\Scripts\activate%0A```%0A%0A3. **Install dependencies:**%0A%0A```bash%0Apip install --upgrade pip setuptools wheel%0Apip install -r autotrader-app/requirements.txt%0A```%0A%0A### Running the Server%0A%0A**Development mode (with auto-reload):**%0A%0A```bash%0Acd autotrader-app%0Auvicorn backend.model:app --reload --host 127.0.0.1 --port 8000%0A```%0A%0A**Production mode:**%0A%0A```bash%0Acd autotrader-app%0Auvicorn backend.model:app --host 0.0.0.0 --port 8000 --workers 4%0A```%0A%0A**Access:**%0A%0A- Root endpoint: <http://localhost:8000/>%0A- API docs (Swagger): <http://localhost:8000/docs>%0A- API docs (ReDoc): <http://localhost:8000/redoc>%0A%0A### API Endpoints%0A%0A#### Health Check%0A%0A```bash%0Acurl http://localhost:8000/%0A# Response: {"Hello":"World"}%0A```%0A%0A#### Create Item%0A%0A```bash%0Acurl -X POST http://localhost:8000/items/ \\%0A  -H "Content-Type: application/json" \\%0A  -d '{"name":"Bitcoin","description":"BTC/KRW","price":50000.00}'%0A# Response: {"name":"Bitcoin","description":"BTC/KRW","price":50000.0}%0A```%0A%0A## Development%0A%0A### Running Tests%0A%0A```bash%0Acd /path/to/krw-autotrader1118%0APYTHONPATH=autotrader-app pytest tests/ -v%0A```%0A%0A**Or** with pyproject.toml (recommended):%0A```bash%0Apytest  # Runs with config from pyproject.toml%0A```%0A%0A### Code Quality%0A%0A**Linting with ruff:**%0A%0A```bash%0Aruff check autotrader-app/ tests/%0A```%0A%0A**Auto-format with ruff:**%0A%0A```bash%0Aruff format autotrader-app/ tests/%0A```%0A%0A**Type checking with mypy (optional):**%0A%0A```bash%0Amypy autotrader-app/backend/ --ignore-missing-imports%0A```%0A%0A### Continuous Integration%0A%0AGitHub Actions automatically runs on every push and PR to `main`:%0A%0A- **Tests:** pytest suite (`tests/`)%0A- **Lint:** ruff code style checks%0A- **Type:** mypy type checking (optional, doesn't block)%0A%0AView CI status: <https://github.com/haenna1118/krw-autotrader1118/actions>%0A%0A## Configuration%0A%0A### Environment Variables%0A%0ACreate a `.env` file in `autotrader-app/` (never commit to git):%0A%0A```dotenv%0A# Example: Exchange credentials (if needed)%0AEXCHANGE_NAME=upbit%0AAPI_KEY=your_api_key%0AAPI_SECRET=your_api_secret%0A```%0A%0ALoad with `python-dotenv`:%0A%0A```python%0Afrom dotenv import load_dotenv%0Aimport os%0A%0Aload_dotenv()%0Aapi_key = os.getenv("API_KEY")%0A```%0A%0A### Linting Config%0A%0ARuff rules are configured in `pyproject.toml` under `[tool.ruff]`:%0A%0A- Line length: 100 characters%0A- Select: E, F, W (errors, warnings, and formatting)%0A- Ignore: E501 (line too long, handled by formatter)%0A%0A## Contributing%0A%0A1. Fork the repository%0A2. Create a feature branch: `git checkout -b feature/your-feature`%0A3. Commit changes: `git commit -m "feat: add your feature"`%0A4. Push to branch: `git push origin feature/your-feature`%0A5. Open a Pull Request%0A%0ACommits must follow [Conventional Commits](https://www.conventionalcommits.org/):%0A%0A- `feat:` New feature%0A- `fix:` Bug fix%0A- `docs:` Documentation%0A- `ci:` CI/CD%0A- `chore:` Dependencies, maintenance%0A- `test:` Test additions/updates%0A%0A## Next Steps%0A%0A1. **Exchange Integration:** Add CCXT wrapper module (`backend/exchanges/`)%0A2. **Trade Models:** Expand Pydantic models for `Trade`, `Order`, `Position`%0A3. **Database:** Add SQLAlchemy for trade history (PostgreSQL recommended)%0A4. **Authentication:** Add FastAPI security (JWT tokens)%0A5. **Async:** Use async CCXT calls for performance%0A6. **Monitoring:** Add logging, metrics, and error tracking%0A%0A## License%0A%0AThis project is provided as-is for educational and development purposes.%0A%0A## Support%0A%0A- **Issues:** <https://github.com/haenna1118/krw-autotrader1118/issues>%0A- **Discussions:** <https://github.com/haenna1118/krw-autotrader1118/discussions>%0A- **AI Agent:** See `.github/copilot-instructions.md` for developer AI guidelines%0A%0A---%0A%0A**Last Updated:** November 16, 2025%0A%0A## Exporting / Downloading the repository to your Desktop%0A%0AUse the helper script `scripts/export_to_desktop.sh` to create a ZIP of the repository%0Aand copy it to a Desktop location automatically. The script tries these options in order:%0A%0A- If `HOST_DESKTOP_PATH` is set and writable, it copies the ZIP there (useful when the host%0A   filesystem is mounted into the container).%0A- Else if `REMOTE_USER_HOST` is set, it uses `scp` to copy the ZIP to `~/Desktop` on the remote host.%0A- Otherwise it will create `/workspaces/krw-autotrader1118.zip` and print instructions for manual download.%0A%0AExamples:%0A%0A```bash%0A# Copy to a local host-mounted Desktop path (container must have write access)%0AHOST_DESKTOP_PATH=/home/you/Desktop ./scripts/export_to_desktop.sh%0A%0A# Or copy to a remote machine via scp (optional port)%0AREMOTE_USER_HOST=user@1.2.3.4 REMOTE_PORT=2222 ./scripts/export_to_desktop.sh%0A```%0A%0ANotes:%0A%0A- The script will create `/workspaces/krw-autotrader1118.zip` if it doesn't already exist.%0A- If you want this to run automatically as part of a CI/build step, call the script from your workflow%0A   and provide the appropriate environment variables.%0A*** End Patch

