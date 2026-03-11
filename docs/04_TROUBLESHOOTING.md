# OpenClaw — Troubleshooting Guide
# Quelle: docs.openclaw.ai/gateway/troubleshooting | Stand: 2026-03-11

---

## DIAGNOSE-SEQUENZ (immer in dieser Reihenfolge!)

```bash
openclaw status                    # Channel-Status + Auth-Fehler
openclaw status --all              # Kompletter Shareable-Report
openclaw gateway probe             # Gateway-Erreichbarkeit pruefen
openclaw gateway status            # Runtime + RPC-Status
openclaw doctor                    # Blocking-Config-Probleme
openclaw channels status --probe   # Channel-Konnektivitaet
openclaw logs --follow             # Live-Logs auf fatale Fehler
```

---

## HAEUFIGE PROBLEME

### Problem: Keine Antworten vom Bot

**Symptome:** Bot verbunden, antwortet aber nicht.

**Diagnose & Loesung:**
```bash
openclaw logs --follow
# Suche nach:
# "drop guild message (mention required)"
# → Mention-Gating aktiv: @openclaw in Gruppenachrichten schreiben

# "Pending DM sender approval"
# → Neuer Sender wartet auf Genehmigung:
openclaw pairing list --channel whatsapp

# Sender/Kanal gefiltert durch Policy
# → allowFrom in Config pruefen
```

---

### Problem: Gateway startet nicht

**EADDRINUSE (Port belegt):**
```bash
# Welcher Prozess nutzt Port 18789?
lsof -i :18789
# Prozess beenden oder anderen Port nutzen:
openclaw gateway --port 18790
```

**"set gateway.mode=local":**
```bash
# In ~/.openclaw/openclaw.json:
# "gateway": { "mode": "local" } setzen
openclaw gateway restart
```

**"refusing to bind gateway without auth":**
```bash
# Non-loopback bind benoetigt Auth — Token setzen:
openclaw config get gateway.auth.token
# Oder: bind auf loopback setzen (sicherer!)
```

---

### Problem: Dashboard verbindet nicht

**Fehlercodes und Loesungen:**

| Code | Bedeutung | Loesung |
|------|-----------|---------|
| `AUTH_TOKEN_MISSING` | Kein Token | Token aus `openclaw config get gateway.auth.token` einfuegen |
| `AUTH_TOKEN_MISMATCH` | Falsches Token | Token-Drift: neu generieren |
| `PAIRING_REQUIRED` | Geraet nicht genehmigt | `openclaw devices approve <requestId>` |
| `device identity required` | Nicht-sicherer Kontext | HTTPS verwenden oder `allowInsecureAuth: true` |
| `device nonce mismatch` | Challenge nicht abgeschlossen | Browser-Cache loeschen, neu verbinden |

---

### Problem: Anthropic 429 Rate Limit

```
"HTTP 429: rate_limit_error: Extra usage is required"
```

**Ursachen & Loesungen:**
```bash
# 1. Modell mit 1M-Kontext auf nicht-berechtigenem Account
# Loesung: context1m deaktivieren:
# In Config: "params": { "context1m": false }

# 2. API-Key ohne Billing
# → Anthropic Console: Billing aktivieren

# 3. Fallback-Modell konfigurieren
# In agents.defaults: sekundaeres Modell angeben
```

---

### Problem: iMessage funktioniert nicht

```bash
# imsg vorhanden?
imsg rpc --help

# Full Disk Access erteilt?
# System Settings → Privacy → Full Disk Access → imsg hinzufuegen

# Automation-Berechtigung?
# System Settings → Privacy → Automation → Messages genehmigen

# Interaktiv ausfuehren (triggert OS-Prompts):
imsg chats --limit 1
```

---

### Problem: macOS Berechtigungen verschwunden

```bash
# Berechtigungen zuruecksetzen:
sudo tccutil reset Accessibility ai.openclaw.mac
sudo tccutil reset ScreenCapture ai.openclaw.mac

# App beenden, in System Settings entfernen, neu starten:
# System Settings → Privacy & Security → Jeweilige Berechtigung → ai.openclaw entfernen
# App neu starten → Berechtigungen neu erteilen

# Falls nichts hilft: Mac neu starten
```

---

### Problem: Browser-Tool funktioniert nicht

```bash
openclaw browser status
openclaw browser profiles

# "Failed to start Chrome CDP"
# → Chrome installiert? Pfad korrekt?

# "executablePath not found"
# → In Config: browser.executablePath setzen
# z.B.: "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Extension-Problem:
# → Extension neu installieren, Tab neu verbinden
```

---

### Problem: Cron/Heartbeat laeuft nicht

```bash
openclaw cron status
openclaw cron list

# "scheduler disabled" → Cron in Config aktivieren
# "heartbeat skipped (quiet-hours)" → Ausserhalb aktiver Zeiten
# "heartbeat skipped (dm-blocked)" → DM-Policy blockiert
```

---

### Problem: Node-Tools schlagen fehl

```bash
# "NODE_BACKGROUND_UNAVAILABLE"
# → Companion App in den Vordergrund holen

# "*_PERMISSION_REQUIRED"
# → macOS-Berechtigung erteilen (System Settings)

# "SYSTEM_RUN_DENIED: approval required"
# → Exec Approval ausstehend:
# Settings → Exec Approvals → Genehmigen
```

---

### Problem: Nach Update kaputt

```bash
# Standard-Wiederherstellung:
openclaw gateway install --force
openclaw gateway restart
openclaw doctor

# Auth-URL-Aenderungen pruefen:
openclaw config get gateway.mode
openclaw config get gateway.remote.url

# Geraete/Pairing-Status:
openclaw devices list
```

---

### Problem: npm-Befehl nicht gefunden

```bash
# PATH-Problem — in ~/.zshrc eintragen:
export PATH="$(npm prefix -g)/bin:$PATH"
source ~/.zshrc

# Dann pruefen:
which openclaw
openclaw --version
```

---

## SCHNELL-REFERENZ ALLE DIAGNOSE-BEFEHLE

```bash
openclaw --version              # Version anzeigen
openclaw status                 # Uebersicht
openclaw status --all           # Vollstaendiger Report
openclaw doctor                 # Config-Validierung
openclaw health                 # Systemgesundheit
openclaw gateway status         # Gateway-Status
openclaw gateway probe          # Gateway-Erreichbarkeit
openclaw channels status --probe # Channel-Status
openclaw logs --follow          # Live-Logs
openclaw pairing list           # Pairing-Anfragen
openclaw devices list           # Verbundene Geraete
openclaw cron status            # Cron-Scheduler
openclaw security audit         # Sicherheits-Check
openclaw browser status         # Browser-Tool-Status
```

---

## HILFE HOLEN

- Offizielle Docs: docs.openclaw.ai
- Community Discord: discord.openclaw.ai (Vorsicht bei fremdem Code!)
- Bug melden: github.com/openclaw/openclaw (nur offizielle Quellen vertrauen)
- Security: security@openclaw.ai

---

> Quelle: docs.openclaw.ai/gateway/troubleshooting | Stand: 2026-03-11
