# OpenClaw Installation Plan — v3 FINAL
# Stand: 2026-03-11 | Für: MacBook (macOS 15+)
# Basiert auf: 3 Research-Runden auf docs.openclaw.ai

---

## KURZUEBERSICHT: Was ist OpenClaw?
Self-hosted, open-source Personal AI Assistant ("The AI that actually does things").
- Laeuft LOKAL auf dem Mac — Daten bleiben bei dir
- Steuert: Mails, Kalender, Browser, Dateien, Terminal — via Chat-Apps
- Unterstuetzt: WhatsApp, Telegram, iMessage, Discord, Slack, Signal u.v.m.
- Kompatibel mit: Anthropic Claude, OpenAI, lokalen Modellen
- Skills-Marktplatz: ClawHub (VirusTotal-gescannt, 100+ Skills)

---

## SCHRITT-FUER-SCHRITT INSTALLATIONSPLAN

---

### PHASE 0 — Vorbereitung (vor Installation)

#### 0.1 Node.js 22+ pruefen
```bash
node --version
```
Ergebnis muss v22.x.x oder hoeher sein.

**Falls nicht installiert:**
```bash
# Option A: Homebrew (empfohlen)
brew install node@22

# Node in PATH aufnehmen (in ~/.zshrc einfuegen):
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
source ~/.zshrc
```

#### 0.2 npm global bin in PATH aufnehmen
In `~/.zshrc` einfuegen:
```bash
export PATH="$(npm prefix -g)/bin:$PATH"
```
Dann:
```bash
source ~/.zshrc
```

#### 0.3 API-Key besorgen (Anthropic empfohlen)
- console.anthropic.com → "API Keys" → "Create Key"
- Key sicher notieren — wird beim Onboarding benoetigt
- Empfohlenes Modell: `claude-opus-4-6` (staerkste Instruction-Following-Qualitaet)

**WICHTIG:** Niemals State-Verzeichnis in iCloud legen!
```bash
# Korrekt (Standard):
~/.openclaw/

# FALSCH — NICHT verwenden:
~/Library/Mobile Documents/...
~/Library/CloudStorage/...
```

---

### PHASE 1 — Installation

#### Methode A: One-Liner (EMPFOHLEN)
```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```
- Erkennt Node.js automatisch
- Installiert alle Abhaengigkeiten
- Startet Onboarding-Wizard

#### Methode B: npm manuell
```bash
npm install -g openclaw@latest
```
> Fehler `sharp` build failure? Dann:
> ```bash
> SHARP_IGNORE_GLOBAL_LIBVIPS=1 npm install -g openclaw@latest
> ```

#### Methode C: pnpm
```bash
pnpm add -g openclaw@latest
pnpm approve-builds -g   # MUSS ausgefuehrt werden!
```

---

### PHASE 2 — Onboarding

```bash
openclaw onboard --install-daemon
```

Der Wizard fragt nach:
1. AI-Provider → "Anthropic" waehlen
2. API-Key eingeben
3. Erstem Chat-Channel

Alternativ nicht-interaktiv:
```bash
openclaw onboard --anthropic-api-key "sk-ant-..."
```

---

### PHASE 3 — Chat-Channel verbinden

#### Option A: WhatsApp (einfachste Methode)
```bash
openclaw channels login
```
QR-Code mit WhatsApp scannen (Geraete verknuepfen).

#### Option B: iMessage (nur Mac)
```bash
# imsg installieren (Homebrew)
brew install steipete/tap/imsg

# Berechtigungen:
# System Settings → Privacy → Full Disk Access → imsg erteilen
# System Settings → Privacy → Automation → Messages erteilen

# Channel in openclaw konfigurieren via Dashboard
```

#### Option C: Telegram
```bash
openclaw channels login
# Telegram-Bot-Token eingeben (via @BotFather erstellen)
```

---

### PHASE 4 — Gateway starten

```bash
# Gateway starten (foreground)
openclaw gateway --port 18789

# ODER: Als Hintergrund-Daemon (LaunchAgent)
openclaw gateway install   # LaunchAgent installieren
```

Dashboard im Browser: `http://127.0.0.1:18789/`

LaunchAgent Verwaltung (Daemon):
```bash
# Starten
launchctl kickstart -k gui/$UID/ai.openclaw.gateway

# Stoppen
launchctl bootout gui/$UID/ai.openclaw.gateway

# Neustart (nach Config-Aenderungen)
openclaw gateway restart
```

---

### PHASE 5 — macOS Berechtigungen erteilen

Bei erstem Start erscheinen TCC-Dialoge — ALLE bestaetigen:

| Berechtigung | Wofuer benoetigt |
|---|---|
| Notifications | Status-Meldungen |
| Accessibility | UI-Steuerung / Automatisierung |
| Screen Recording | Screenshot-Faehigkeiten |
| Microphone | Voice-Features |
| Speech Recognition | Voice Wake |
| Automation/AppleScript | App-Steuerung |
| Full Disk Access | iMessage-Datenbankzugriff |

**Berechtigungen zuruecksetzen (falls Probleme):**
```bash
sudo tccutil reset Accessibility ai.openclaw.mac
sudo tccutil reset ScreenCapture ai.openclaw.mac
# Dann App neu starten
```

**Tipp:** Dateien besser in `~/.openclaw/workspace/` ablegen statt in Desktop/Documents — vermeidet Einzelgenehmigungen.

---

### PHASE 6 — Companion App (macOS 15+, optional)

1. Download von openclaw.ai → "Companion App"
2. In `/Applications/` verschieben
3. Starten → Menubar-Icon erscheint
4. Features:
   - Menubar-Icon mit Live-Status (zeigt was der Agent gerade tut)
   - Voice Wake (Aktivierung per Stimme)
   - Canvas (visuelle Ausgaben)
   - Voice Overlay

---

### PHASE 7 — Erster Test

```bash
# Diagnose-Sequenz (immer in dieser Reihenfolge!)
openclaw doctor              # Konfiguration validieren
openclaw status              # Channel-Status
openclaw health              # Systemgesundheit
openclaw logs --follow       # Live-Logs beobachten
```

Dann in WhatsApp/Telegram schreiben:
> "Hallo, was kannst du tun?"

---

## KONFIGURATIONS-DATEI

Pfad: `~/.openclaw/openclaw.json`

Empfohlene Grundkonfiguration:
```json5
{
  // Gateway-Sicherheit
  "gateway": {
    "bind": "loopback",          // Nur lokal — niemals 0.0.0.0 ohne Auth!
    "auth": {
      "mode": "token"            // Token-Auth aktiviert
    }
  },

  // Standard-Modell
  "agents": {
    "defaults": {
      "model": {
        "primary": "anthropic/claude-opus-4-6"
      }
    }
  },

  // Security: Secrets aus Logs
  "logging": {
    "redactSensitive": "tools"
  },

  // Exec-Approvals (Shell-Ausfuehrung)
  // Wird in ~/.openclaw/exec-approvals.json gespeichert
}
```

---

## UPDATE-PROZESS

```bash
# Standard (empfohlen):
curl -fsSL https://openclaw.ai/install.sh | bash

# oder:
npm i -g openclaw@latest

# Nach JEDEM Update:
openclaw doctor
openclaw gateway restart
openclaw health
```

Kanal wechseln:
```bash
openclaw update --channel stable   # Standard
openclaw update --channel beta     # Mehr Features, weniger stabil
```

Rollback:
```bash
npm i -g openclaw@<version>
```

---

## BACKUP-STRATEGIE

```bash
# Alles liegt in:
~/.openclaw/

# Sichern (z.B. auf externe Festplatte):
rsync -av ~/.openclaw/ /Volumes/Backup/openclaw-backup/

# WICHTIG: Niemals credentials committen!
# Workspace kann in privates Git-Repo:
cd ~/.openclaw/workspace
git init && git remote add origin <dein-privates-repo>
```

---

> Version: FINAL v3 | Alle Infos aus docs.openclaw.ai
