# Openclaw-Setup-Agent

**From zero to running personal AI agent in under 10 minutes.**

Full setup guide, security hardening, agent templates, and self-monitoring — everything you need to run [OpenClaw](https://openclaw.ai) on your Mac (or any machine).

> OpenClaw is a self-hosted, open-source AI agent that runs locally and works from the chat apps you already use — Telegram, WhatsApp, iMessage, Discord and more.

---

## What's in here

```
docs/                        Complete documentation
├── 00_INSTALL_PLAN.md       Full step-by-step install plan
├── 01_SETUP.md              macOS setup guide
├── 02_SECURITY.md           Security hardening + audit
├── 03_MAINTENANCE.md        Updates, backup, daemon management
├── 04_TROUBLESHOOTING.md    Diagnostics + common fixes
├── 05_INTEGRATIONS.md       Channels, models, skills
└── 06_ROADMAP.md            Roadmap + personal context setup

agent/                       Blank reference templates (always clean, always public)
├── SOUL.md                  Personality, tone, values
├── IDENTITY.md              Name, role, emoji, avatar
├── BOOT.md                  Startup behavior
├── HEARTBEAT.md             Periodic monitoring tasks
└── MONITORING.md            Agent self-monitoring architecture

your-context/                YOUR personal context — fill this in (gitignored)
└── README.md                Instructions: what to fill in and how

SETUP_QUESTIONNAIRE.md       Answer these before setup — guides your agent files
deploy.sh                    Links your-context/ to OpenClaw workspace
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
git clone https://github.com/hellonewways/claudeskills.git openclaw-setup-agent
cd openclaw-setup-agent
```

### 3. Add your personal context

Open the `your-context/` folder. Fill in the files there.

Use `SETUP_QUESTIONNAIRE.md` as your guide — or drop your CV, business description, and notes into `your-context/` and let a Claude Code session auto-fill everything for you.

> `your-context/` is gitignored. Your data stays local. It will never be pushed to GitHub.

### 4. Deploy
```bash
bash deploy.sh
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

## What stays private

Everything in `your-context/` — never pushed here:
- `SOUL.md`, `IDENTITY.md` — your filled versions
- `MEMORY.md` — personal and business context
- `USER.md` — your profile
- Any documents you added for context

Store your filled `your-context/` content in a **private repo** or keep it local-only.

---

## Contributing

Found something wrong or missing? Open an issue or PR.
Tested on macOS 15+. Works on Linux and Windows (WSL2).

---

Built on: [docs.openclaw.ai](https://docs.openclaw.ai) | MIT License
