# Contributing to PhishGuard AI

Thanks for your interest in improving PhishGuard AI. This is a portfolio / educational project, and contributions that keep it **100% free, offline-first, and dependency-light** are especially welcome.

## Ground Rules

Any contribution must preserve the project's core guarantees:

1. **No paid services.** No paid APIs, SaaS, cloud AI, or commercial software may become a requirement.
2. **No mandatory API keys, accounts, or credit cards.**
3. **Offline-first.** Core detection (URL analysis, ML prediction, email/header analysis, risk scoring, database, reports) must keep working with no internet connection.
4. **Defensive only.** No code that visits, executes, or downloads content from analyzed URLs; no code that automates attacks or interacts with live malicious infrastructure.
5. **Free/open-source stack only** (see `README.md` → Technology Stack).

## Development Setup

```bash
git clone <your-fork-url>
cd PhishGuardAI
python -m venv venv
source venv/bin/activate        # Windows: venv\Scripts\activate
pip install -r requirements.txt
python scripts/generate_dataset.py
python scripts/init_db.py
python scripts/train_model.py
python app/main.py
```

## Running Tests

```bash
pytest -v
```

All new features should include tests under `tests/`. Please keep the suite fast and fully offline (mock/patch any network calls).

## Code Style

- Follow the existing module docstring style: a short header explaining the file's purpose and any safety constraints.
- Functions that can fail (parsing, DNS, file I/O) should degrade gracefully — return a clear "unavailable"/error state rather than raising into the GUI thread.
- Never log secrets. Use `app.core.logger.get_logger()`.
- Any GUI-blocking work (network, ML training, large analysis) must run in a `QThread` worker (see `app/ui/workers.py`).

## Adding a New Threat-Intel Source

New sources must subclass `app.threat_intel.base.ThreatIntelSource`, be registered via `ThreatIntelManager.register_source()`, and:

- Default to disabled/optional if they require network access or an API key.
- Never be required for the application to function.
- Fail closed (return no findings) rather than raising when unavailable.

## Submitting Changes

1. Fork the repository and create a feature branch.
2. Make your changes with tests.
3. Run `pytest -v` and ensure everything passes.
4. Open a pull request describing the change and why it preserves the project's free/offline-first guarantees.

## Reporting Bugs / Requesting Features

Please open a GitHub issue with clear reproduction steps (for bugs) or a clear use case (for features). For security-sensitive reports, see `SECURITY.md`.
