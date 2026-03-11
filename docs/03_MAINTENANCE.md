# OpenClaw — Maintenance Guide
# Quelle: docs.openclaw.ai | Stand: 2026-03-11

---

## UPDATES

### Standard-Update (empfohlen)
```bash
# Re-run Installer (erkennt vorhandene Installation automatisch)
curl -fsSL https://openclaw.ai/install.sh | bash

# oder via npm:
npm i -g openclaw@latest

# oder via pnpm:
pnpm add -g openclaw@latest
```

### Nach JEDEM Update unbedingt ausfuehren:
```bash
openclaw doctor          # Migration & Config-Pruefung
openclaw gateway restart  # Gateway neu starten
openclaw health           # Gesundheitscheck
```

### Update-Kanal wechseln
```bash
openclaw update --channel stable  # Standard (empfohlen)
openclaw update --channel beta    # Mehr Features, weniger stabil
openclaw update --channel dev     # Manuell, nur fuer Entwickler
```

### Rollback auf bestimmte Version
```bash
npm i -g openclaw@<version>
# z.B.: npm i -g openclaw@1.2.3
```

### Automatische Updates (optional)
In `~/.openclaw/openclaw.json` konfigurierbar (standardmaessig deaktiviert).

---

## DAEMON VERWALTUNG (LaunchAgent auf macOS)

```bash
# Installieren (einmalig)
openclaw gateway install

# Status pruefen
openclaw gateway status

# Starten
launchctl kickstart -k gui/$UID/ai.openclaw.gateway

# Stoppen
launchctl bootout gui/$UID/ai.openclaw.gateway

# Neustart (z.B. nach Config-Aenderung)
openclaw gateway restart

# Deinstallieren
openclaw gateway uninstall
```

LaunchAgent-Datei befindet sich in:
`~/Library/LaunchAgents/ai.openclaw.gateway.plist`

---

## LOGS

```bash
# Live-Logs verfolgen
openclaw logs --follow

# Logs nach Fehlern durchsuchen
openclaw logs | grep -i error

# Gateway-Logs direkt
openclaw gateway status
```

Logdateien:
- `~/.openclaw/logs/` (Standardpfad)
- macOS Companion App: via Xcode Console oder Menubar-Debug-Option

---

## BACKUP

### Was muss gesichert werden?
```
~/.openclaw/
├── openclaw.json          # Konfiguration
├── credentials/           # Channel-Credentials (WhatsApp etc.)
├── agents/                # Agent-Workspaces + Sessions
│   └── */sessions/*.jsonl # Chat-Transkripte
└── workspace/             # Arbeitsbereich des Agents
```

### Backup-Befehl
```bash
# Komplettes Backup auf externe Festplatte/Netzlaufwerk:
rsync -av --exclude='node_modules' \
  ~/.openclaw/ \
  /Volumes/Backup/openclaw-$(date +%Y%m%d)/

# WICHTIG: Backup ist sensitiv — verschluesseln!
```

### Workspace in Git (empfohlen)
```bash
cd ~/.openclaw/workspace
git init
git remote add origin git@github.com:<dein-privates-repo>.git

# .gitignore erstellen:
echo "credentials/" >> .gitignore
echo "*.key" >> .gitignore
echo "*.token" >> .gitignore

git add -A
git commit -m "Initial workspace"
```
**NIEMALS `~/.openclaw/credentials/` committen!**

---

## MIGRATION (neues Geraet)

```bash
# Auf altem Geraet: Backup erstellen (siehe oben)

# Auf neuem Geraet:
# 1. OpenClaw installieren (Phase 1+2)
# 2. Backup kopieren:
rsync -av /Volumes/Backup/openclaw-latest/ ~/.openclaw/

# 3. Berechtigungen setzen:
chmod 700 ~/.openclaw/
chmod 700 ~/.openclaw/credentials/
chmod 600 ~/.openclaw/openclaw.json
chmod 600 ~/.openclaw/credentials/**/*.json

# 4. Diagnose:
openclaw doctor
openclaw gateway restart
openclaw health
```

---

## GESUNDHEITS-CHECKS (regelmaessig ausfuehren)

```bash
# Woechentlich empfohlen:
openclaw doctor
openclaw security audit
openclaw health

# Nach Config-Aenderungen:
openclaw doctor --full
openclaw gateway restart

# Alle Channels pruefen:
openclaw channels status --probe
```

---

## SKILLS VERWALTEN (ClawHub)

```bash
# CLI installieren
npm i -g clawhub

# Skills suchen
clawhub search "calendar"
clawhub search "gmail"

# Skill installieren
clawhub install <skill-slug>

# Nach JEDER Skill-Installation:
openclaw security audit --fix

# Skills auflisten
openclaw skills list

# Skill deinstallieren
openclaw skills remove <skill-name>
```

**Sicherheitshinweis:** ClawHub-Skills werden per VirusTotal gescannt.
Drittanbieter-Skills (GitHub, Discord) sind NICHT gescannt — mit Vorsicht verwenden!

---

## UNINSTALL

```bash
# Daemon stoppen und entfernen
openclaw gateway uninstall

# openclaw Paket entfernen
npm uninstall -g openclaw

# Daten entfernen (optional — UNWIEDERBRINGLICH!)
rm -rf ~/.openclaw/
```

---

> Quelle: docs.openclaw.ai | Stand: 2026-03-11
