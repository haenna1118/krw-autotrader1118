# CHANGELOG

All notable changes to this project will be documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/) principles with simplified sections.

## Unreleased

### Added

- AI Agent Instructions (`.github/copilot-instructions.md`) for guiding coding agents
- Test suite with FastAPI TestClient (commit: 423790c, 2025-11-16)
  - `tests/test_model.py`: HTTP tests for `GET /` and `POST /items/`
- Package structure: `autotrader-app/backend/__init__.py` for proper Python imports
- Dependencies management: `autotrader-app/requirements.txt` with core and test packages

### Fixed

- Remove accidentally inserted shell commands from `model.py` (commit: 9a8ba60, 2025-11-16)
  - Restored `create_item()` return statement for proper JSON response
  - Server now runs cleanly with uvicorn

### Changed

- Improved type hints: Use `Optional[str]` instead of `str = None` in Item model
- Removed duplicate code in `backend/model.py`

---

**Latest commits (2025-11-16):**

- 9a8ba60 - fix: remove stray shell text from model.py and restore create_item return
- dc0e3b8 - chore: add CHANGELOG.md (generated)
- 423790c - chore: clean model, add tests, add copilot instructions and requirements
