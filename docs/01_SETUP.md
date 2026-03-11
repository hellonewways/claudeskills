# OpenClaw — Setup Guide (macOS)
# Quelle: docs.openclaw.ai | Stand: 2026-03-11

---

## Voraussetzungen

- macOS beliebig (15+ fuer Companion App)
- Node.js 22+
- npm
- API-Key (Anthropic/OpenAI/etc.)
- Internetzugang fuer Installation

---

## Schritt 1: Node.js 22+ installieren

```bash
# Pruefen ob vorhanden:
node --version

# Falls nicht: Homebrew-Installation
brew install node@22

# In ~/.zshrc eintragen:
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
export PATH="$(npm prefix -g)/bin:$PATH"

# Neu laden:
source ~/.zshrc
```

---

## Schritt 2: OpenClaw installieren

### Empfohlen: One-Liner
```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

### Alternativ: npm
```bash
# Bei sharp-Fehler:
SHARP_IGNORE_GLOBAL_LIBVIPS=1 npm install -g openclaw@latest
```

### Alternativ: pnpm
```bash
pnpm add -g openclaw@latest
pnpm approve-builds -g
```

---

## Schritt 3: Onboarding

```bash
openclaw onboard --install-daemon
```

Wizard fragt nach:
- AI-Provider (Anthropic empfohlen)
- API-Key
- Erstem Chat-Channel

---

## Schritt 4: Channel verbinden

### WhatsApp
```bash
openclaw channels login
# QR-Code scannen
```

### iMessage (Mac only)
```bash
brew install steipete/tap/imsg
# Full Disk Access + Automation in System Settings erteilen
```

### Telegram
```bash
# Bot bei @BotFather erstellen → Token eingeben
openclaw channels login
```

---

## Schritt 5: Gateway

```bash
# Manuell starten:
openclaw gateway --port 18789

# Als Daemon (Autostart):
openclaw gateway install

# Dashboard:
open http://127.0.0.1:18789/
```

---

## Schritt 6: Diagnose

```bash
openclaw doctor
openclaw status
openclaw health
openclaw logs --follow
```

---

## Schritt 7: macOS Companion App (optional, macOS 15+)

1. Download von openclaw.ai
2. In /Applications/ verschieben
3. Starten
4. TCC-Berechtigungen alle bestaetigen:
   - Notifications, Accessibility, Screen Recording
   - Microphone, Speech Recognition, Automation

---

## Tipps

- State-Verzeichnis: `~/.openclaw/` — NIEMALS in iCloud!
- Config: `~/.openclaw/openclaw.json`
- Workspace: `~/.openclaw/workspace/`
- Dateien hier ablegen vermeidet Extra-Berechtigungen

---

## Naechste Schritte
- → 02_SECURITY.md (Sicherheit haerten)
- → 03_MAINTENANCE.md (Updates, Backup)
- → 04_TROUBLESHOOTING.md (Probleme loesen)
