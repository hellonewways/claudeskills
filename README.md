# Openclaw Auto Setup

**From zero to running personal AI agent in under 10 minutes.**

Full setup guide, security hardening, agent template, and self-monitoring — everything you need to run [OpenClaw](https://openclaw.ai) on your Mac (or any machine).

> OpenClaw is a self-hosted, open-source AI agent that runs locally and works from the chat apps you already use — WhatsApp, Telegram, iMessage, Discord and more.

---

## What's in here

```
docs/                        Complete documentation
├── 00_INSTALL_PLAN.md       Full step-by-step install plan
├── 01_SETUP.md              macOS setup guide
├── 02_SECURITY.md           Security hardening + audit
├── 03_MAINTENANCE.md        Updates, backup, daemon management
├── 04_TROUBLESHOOTING.md    Diagnostics + common fixes
├── 05_INTEGRATIONS.md       Channels, models, ClawHub skills
└── 06_ROADMAP.md            Roadmap + business context setup

agent/                       Blank agent template files
├── SOUL.md                  Personality, tone, values
├── IDENTITY.md              Name, role, emoji, avatar
├── BOOT.md                  Startup behavior
├── HEARTBEAT.md             Periodic monitoring tasks
├── MONITORING.md            KI-watches-KI architecture
└── USER.md                  User profile (gitignored)

SETUP_QUESTIONNAIRE.md       Fill this in before setup
deploy.sh                    One-command deploy to workspace
```

---

## Quickstart

### 1. Install OpenClaw
```bash
curl -fsSL https://openclaw.ai/install.sh | bash
openclaw onboard --install-daemon
```
Requires: Node.js 22+ and an API key ([Anthropic](https://console.anthropic.com) recommended).

### 2. Clone this repo
```bash
git clone https://github.com/mropenclaw/openclaw-auto-setup.git
cd openclaw-auto-setup
```

### 3. Configure your agent
Fill in the `agent/` files — replace all `[PLACEHOLDERS]` with your info:
- `SOUL.md` — personality and tone
- `IDENTITY.md` — name and role
- `BOOT.md` — startup behavior (optional)
- `HEARTBEAT.md` — monitoring schedule (pre-filled with sensible defaults)

> `USER.md` is gitignored — fill it in locally, never commit it.

### 4. Deploy
```bash
bash deploy.sh
openclaw gateway restart
```

Done. Open your chat app and say hello.

---

## Self-monitoring included

`HEARTBEAT.md` runs automated checks on schedule:
- Daily: `openclaw doctor`, security audit, log review
- Weekly: deep security scan, update check, device review
- On anomaly: instant notification via your chat channel

See `agent/MONITORING.md` for the full architecture.

---

## Already have info about yourself?

Drop files into a local `context-input/` folder (CV, business description, notes — anything).
A Claude Code session can scan them and auto-fill your agent files, then ask only the gaps.
See `SETUP_QUESTIONNAIRE.md` if you prefer answering questions directly.

---

## What stays private

Gitignored — keep these local only:
- `agent/MEMORY.md` — long-term memory (personal/business context)
- `agent/USER.md` — your profile
- `agent/memory/` — daily session logs

Store these in a **private repo** or encrypted local folder.

---

## Contributing

Found something wrong or missing? Open an issue or PR.
Tested on macOS 15+. Works on Linux and Windows (WSL2).

---

Built on: [docs.openclaw.ai](https://docs.openclaw.ai) | MIT License
