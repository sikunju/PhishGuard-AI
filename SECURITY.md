# Security Policy

PhishGuard AI is a **defensive** cybersecurity education and portfolio project. This document explains its security posture, safe-usage boundaries, and how to report issues.

## Scope and Intent

PhishGuard AI is designed to **analyze** URLs, emails, and email headers for phishing indicators. It is explicitly designed to:

- Never visit, fetch, execute, or download content from a submitted URL.
- Never execute downloaded files or attachments.
- Never run user input through a shell (`cmd.exe`, `subprocess` with `shell=True`, `os.system`, `eval`, `exec`).
- Never store plaintext passwords or require the user to enter any credential.
- Never require or embed any API key, secret, or token in source code.
- Never transmit scan data to any third-party or cloud service by default.

## Data Handling

- All scan data is stored locally in a SQLite database (`phishguard.db`) on the user's machine.
- Logs are written locally under `logs/` and are automatically redacted of common secret patterns (API keys, passwords, tokens, Authorization headers) before being written.
- No telemetry, analytics, or crash reporting is transmitted anywhere.
- The only outbound network activity the application can ever perform is:
  1. An optional, user-triggered raw TCP connectivity probe (no data sent) to well-known public DNS resolvers, used purely to display an ONLINE/OFFLINE indicator.
  2. An optional, user-triggered DNS lookup (A/AAAA/MX/NS/CNAME) for a domain the user is actively analyzing.
  Both are OFF by default in the sense that core detection never requires them, and both fail closed (return "unavailable") instead of raising or hanging.

## Input Validation

- URLs, email text, and headers are length-capped and validated before processing.
- URL parsing uses Python's standard `urllib.parse` only; there is no custom parser vulnerable to injection.
- SQL queries are 100% parameterized (no string-built SQL).
- File paths used for local threat-intel lists and reports are fixed, application-controlled locations under the project directory — user input is never used to construct a filesystem path that is then opened/executed.

## Reporting a Vulnerability

This is a portfolio/education project, not a production security product. If you find a security issue:

1. Do not open a public issue with exploit details.
2. Open a GitHub issue titled `[SECURITY]` with a high-level description, or contact the maintainer directly if a security contact is listed in the repository.
3. Include reproduction steps, the affected file/module, and potential impact.

## Known Limitations

See `README.md` → **Limitations** and `docs/security.md` for a full list. In short: this tool produces a **risk assessment**, not a guarantee, and is not a substitute for enterprise-grade email security or threat-intelligence platforms.
