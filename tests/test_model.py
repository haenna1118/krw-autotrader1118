import os
import sys

# Ensure `autotrader-app` is on sys.path so `backend` can be imported
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
AUTOTRADER_APP = os.path.join(ROOT, "autotrader-app")
if AUTOTRADER_APP not in sys.path:
    sys.path.insert(0, AUTOTRADER_APP)

# Imports below require `autotrader-app` on `sys.path` — noqa E402 is used
from fastapi.testclient import TestClient  # noqa: E402, I001

from backend.model import app  # noqa: E402, I001

client = TestClient(app)


def test_read_root():
    r = client.get("/")
    assert r.status_code == 200
    assert r.json() == {"Hello": "World"}


def test_create_item():
    payload = {"name": "test", "description": "desc", "price": 1.23}
    r = client.post("/items/", json=payload)
    assert r.status_code == 200
    assert r.json() == payload
