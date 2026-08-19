# Changelog

All notable changes to PhishGuard AI are documented in this file.

## [1.0.0] - 2026-08-17

### Added
- Initial public release of PhishGuard AI.
- Local, offline-first URL phishing detection engine with 25 explainable heuristic features.
- Local scikit-learn ML pipeline (Random Forest / Gradient Boosting / Logistic Regression) with real, non-fabricated evaluation metrics.
- Local threat-intelligence engine (suspicious domains, TLDs, keywords, regex phishing patterns, disposable email domains) — fully offline and user-editable.
- Modular threat-intel architecture (`app/threat_intel/base.py`) supporting future optional free sources without breaking offline operation.
- Combined local risk-scoring engine (heuristics + ML + threat intel + domain analysis) with a 0-100 score and 5-band classification (SAFE → CRITICAL).
- Email phishing analyzer: social-engineering language detection, brand-impersonation detection, and automatic URL extraction/re-scanning.
- Email header analyzer: SPF/DKIM/DMARC parsing, sender/domain mismatch detection, sending-IP extraction.
- Optional, best-effort domain/DNS analysis (A/AAAA/MX/NS/CNAME) that degrades to "DNS ANALYSIS UNAVAILABLE" offline.
- Local SQLite scan history with search, filter, sort, view, delete, and CSV/JSON export.
- HTML/JSON/CSV report generation with executive summary, indicators, and recommended actions.
- Professional PySide6 dark-themed SOC console GUI: Dashboard, URL Scanner, Email Analyzer, Email Header Analyzer, Threat Intelligence, Scan History, Reports, ML Model, Settings, About.
- Background QThread workers for all analysis, DNS, connectivity, and training operations — the UI never freezes.
- Rotating, secret-redacting application logging.
- Synthetic, safe demonstration dataset (`datasets/sample_urls.csv`) and a deterministic generator script.
- Full pytest suite (47 tests) covering URL features, risk engine, ML pipeline, email/header analysis, database, reports, and error handling.
- Windows setup/run/build batch scripts (`setup_windows.bat`, `run_windows.bat`, `build_windows.bat`) producing a portable `PhishGuardAI.exe` via PyInstaller.
- Full documentation set under `docs/`.

### Security
- Zero mandatory external dependencies beyond free/open-source Python packages.
- No API keys, cloud accounts, subscriptions, or paid services anywhere in the codebase.
