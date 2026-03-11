# Changelog

All notable changes to Openclaw Auto Setup are documented here.

Format: `[version] — date — summary`

---

## [v1.0] — 2026-03-11 — Initial release

### Added
- `docs/00_INSTALL_PLAN.md` — Full step-by-step macOS install plan (Phase 0–7)
- `docs/01_SETUP.md` — macOS setup guide
- `docs/02_SECURITY.md` — Security hardening + audit checklist
- `docs/03_MAINTENANCE.md` — Updates, backup, daemon management
- `docs/04_TROUBLESHOOTING.md` — Diagnostics + common fixes
- `docs/05_INTEGRATIONS.md` — Channels, models, ClawHub skills
- `docs/06_ROADMAP.md` — Roadmap + personal context setup
- `agent/SOUL.md` — Blank personality template
- `agent/IDENTITY.md` — Blank identity template
- `agent/BOOT.md` — Blank startup behavior template
- `agent/HEARTBEAT.md` — Pre-filled monitoring schedule (daily + weekly)
- `agent/MONITORING.md` — KI-watches-KI architecture
- `SETUP_QUESTIONNAIRE.md` — 7-section questionnaire for new users
- `deploy.sh` — Reference template (redirects to personal deploy script)
- `.gitignore` — Safety net for personal data
- Two-folder architecture: public repo always blank, personal data in `Openclaw Personal/`
- Self-monitoring loop: OpenClaw monitors itself, Claude Code as external oversight layer

---

<!--
Template for future entries:

## [vX.Y] — YYYY-MM-DD — Short description

### Added
- ...

### Changed
- ...

### Fixed
- ...

### Removed
- ...
-->
