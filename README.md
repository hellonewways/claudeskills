# Openclaw Auto Setup

**From zero to running personal AI agent in under 10 minutes.**

Full setup guide, security hardening, agent template, and self-monitoring — everything you need to run [OpenClaw](https://openclaw.ai) on your Mac (or any machine).

> OpenClaw is a self-hosted, open-source AI agent that runs locally and works from the chat apps you already use — WhatsApp, Telegram, iMessage, Discord and more.

---

## What's in here

```
docs/                        Complete documentation (the valuable part)
├── 00_INSTALL_PLAN.md       Full step-by-step install plan
├── 01_SETUP.md              macOS setup guide
├── 02_SECURITY.md           Security hardening + audit
├── 03_MAINTENANCE.md        Updates, backup, daemon management
├── 04_TROUBLESHOOTING.md    Diagnostics + common fixes
├── 05_INTEGRATIONS.md       Channels, models, ClawHub skills
└── 06_ROADMAP.md            Roadmap + personal context setup

agent/                       Blank template files — always clean, always public
├── SOUL.md                  Personality, tone, values
├── IDENTITY.md              Name, role, emoji, avatar
├── BOOT.md                  Startup behavior
├── HEARTBEAT.md             Periodic monitoring tasks (pre-filled)
└── MONITORING.md            KI-watches-KI architecture

SETUP_QUESTIONNAIRE.md       Answer these before setup
deploy.sh                    Reference — see Two-folder architecture below
```

---

## Two-folder architecture

This repo stays clean. Your personal data lives separately — never in this repo.

```
Openclaw Auto Setup/     ← This repo (GitHub, always public, always blank)
    agent/               ← Blank templates only

Openclaw Personal/       ← Local only, never pushed here
    agent/               ← YOUR filled versions (SOUL, IDENTITY, MEMORY...)
    context-input/       ← Drop your CV, notes, business docs here
    deploy.sh            ← The script you actually run
```

**Result:** You can keep improving and pushing this repo without ever risking
your personal data leaking in. Two separate concerns, zero overlap.

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

### 3. Create your personal folder
```bash
mkdir -p "Openclaw Personal/agent"
cp deploy.sh "Openclaw Personal/deploy.sh"   # copy the deploy script
```

Fill in the files in `Openclaw Personal/agent/` — never in this repo's `agent/`.
Use `SETUP_QUESTIONNAIRE.md` as your guide, or drop files into `context-input/`
and let a Claude Code session auto-fill everything for you.

### 4. Deploy from your personal folder
```bash
cd "Openclaw Personal"
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

## Already have info about yourself?

Drop files into a local `context-input/` folder (CV, business description, notes — anything).
A Claude Code session can scan them and auto-fill your agent files, then ask only the gaps.
See `SETUP_QUESTIONNAIRE.md` if you prefer answering questions directly.

---

## What stays private

Everything in `Openclaw Personal/` — never in this repo:
- `SOUL.md`, `IDENTITY.md` — your filled versions
- `MEMORY.md` — personal and business context
- `USER.md` — your profile
- `memory/` — daily session logs
- `context-input/` — documents you scanned

Store `Openclaw Personal/` in a **private repo** or keep it local-only.

---

## Contributing

Found something wrong or missing? Open an issue or PR.
Tested on macOS 15+. Works on Linux and Windows (WSL2).

---

Built on: [docs.openclaw.ai](https://docs.openclaw.ai) | MIT License
