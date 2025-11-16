# AI Agent Instructions for KRW AutoTrader

## Project Overview

**KRW AutoTrader** is a FastAPI-based backend application for automated cryptocurrency trading with Korean won (KRW) support. The project integrates with CCXT (CryptoCurrency eXchange Trading library) for exchange connectivity and uses Pydantic for data validation.

**Technology Stack:**
- FastAPI (async Python web framework)
- Pydantic (data validation using Python type hints)
- CCXT (cryptocurrency exchange integration)
- Uvicorn (ASGI server)
- python-dotenv (environment configuration)

## Project Structure

```
autotrader-app/
└── backend/
    └── model.py          # Main FastAPI app with Item data model
```

**Note:** This is an early-stage project with minimal files. Expect expansion as features are added.

## Architecture & Data Flows

### Current State
- **model.py** contains:
  - FastAPI application instance (`app`)
  - `Item` Pydantic model (name, description, price)
  - Two endpoints:
    - `GET /` - Returns health check message
    - `POST /items/` - Creates/echoes Item data

### Intended Architecture (Inferred)
Based on dependencies (CCXT, python-dotenv), the application is designed to:
1. Connect to cryptocurrency exchanges via CCXT
2. Manage trading configurations (likely via Item model evolution)
3. Execute automated trading strategies
4. Support Korean won pair trading

## Development Setup & Workflows

### Environment Configuration
- **Location:** `.venv/` (virtual environment)
- **Dependencies:** `requirements.txt` in autotrader-app directory
- **Current deps:** fastapi, uvicorn, pydantic, ccxt, python-dotenv

### Running the Application
```bash
# Start the API server (typically runs on http://localhost:8000)
cd /workspaces/krw-autotrader1118/autotrader-app
uvicorn backend.model:app --reload
```

### API Documentation
- **Automatic docs:** Visit `http://localhost:8000/docs` (Swagger UI)
- **Alternative docs:** `http://localhost:8000/redoc` (ReDoc)

## Code Patterns & Conventions

### Pydantic Model Usage
The `Item` model demonstrates the project's approach to validation:
```python
class Item(BaseModel):
    name: str
    description: str = None  # Optional field with default
    price: float
```

**Pattern:** Use Pydantic models for all request/response bodies. FastAPI auto-validates incoming JSON.

### FastAPI Endpoint Structure
```python
@app.get("/")
def read_root():
    return {"Hello": "World"}
```

**Pattern:** Use decorator-based routing. Keep handlers concise; extract complex logic to separate modules.

## Integration Points & External Dependencies

### CCXT (Critical Integration)
- **Purpose:** Exchange API abstraction layer for trading pairs, market data, order execution
- **Expected patterns:**
  - Initialize exchange: `exchange = ccxt.binance({'apiKey': '...', 'secret': '...'})`
  - Query pairs: `exchange.fetch_tickers()`, `exchange.fetch_ohlcv()`
  - Execute trades: `exchange.create_market_order()`, `exchange.create_limit_order()`
- **KRW-specific:** CCXT supports KRW pairs on Korean exchanges (Upbit, Bithumb); confirm exchange selection when implementing

### Environment Variables (python-dotenv)
- **Expected keys:** API keys, exchange names, trading parameters
- **Pattern:** Load via `dotenv.load_dotenv()` and access with `os.getenv()`
- **Security:** Never commit `.env` file; document required keys in comments

## Key Files & Exemplars

| File | Purpose | Exemplar Pattern |
|------|---------|------------------|
| `backend/model.py` | Application entry point | FastAPI app initialization, Pydantic models, endpoint definitions |

## Next Steps for Contributors

1. **Expand models:** Add `Trade`, `ExchangeConfig`, `Strategy` models as Pydantic classes
2. **Add exchange layer:** Create `backend/exchanges/` module wrapping CCXT
3. **Implement endpoints:** `/trades/`, `/config/`, `/execute/` for trading operations
4. **Add tests:** Use pytest with FastAPI's TestClient for endpoint testing
5. **Logging & error handling:** Use Python's logging module; FastAPI handles HTTP exceptions

## Assumptions & Limitations

- Single-file backend (may need refactoring for multi-module features)
- No database layer yet (consider SQLAlchemy for trade history)
- No authentication (add FastAPI security for API key protection)
- Synchronous CCXT calls (consider async wrappers for performance)
