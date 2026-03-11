# OpenClaw — Integrations Guide
# Quelle: docs.openclaw.ai | Stand: 2026-03-11

---

## CHAT-PROVIDER (Channels)

| Channel | Plattform | Setup-Schwierigkeit |
|---------|-----------|---------------------|
| WhatsApp | Alle | Einfach (QR-Code) |
| Telegram | Alle | Einfach (Bot-Token) |
| iMessage | Mac only | Mittel (imsg-Tool) |
| Discord | Alle | Einfach (Bot-Token) |
| Signal | Alle | Mittel |
| Slack | Alle | Mittel (App-Token) |
| Microsoft Teams | Alle | Mittel |
| Matrix | Alle | Mittel |
| WebChat | Browser | Einfach |
| IRC | Alle | Einfach |

---

## SETUP PRO CHANNEL

### WhatsApp
```bash
openclaw channels login
# → WhatsApp waehlen
# → QR-Code scannen: WhatsApp → Geraete → Geraet hinzufuegen
```

### Telegram
```bash
# 1. @BotFather in Telegram kontaktieren
# 2. /newbot → Name und Username waehlen → Token erhalten
# 3. Token eingeben:
openclaw channels login
# → Telegram waehlen → Token eingeben
```

### iMessage (Mac only)
```bash
# 1. imsg installieren:
brew install steipete/tap/imsg

# 2. Berechtigungen in System Settings:
# Full Disk Access → imsg hinzufuegen
# Automation → Messages.app genehmigen

# 3. Test (triggert OS-Prompts):
imsg chats --limit 1

# 4. In openclaw.json konfigurieren:
# Pfad zu imsg und Messages-Datenbank angeben
```

### Discord
```bash
# 1. discord.com/developers → Application → Bot erstellen
# 2. Token kopieren
# 3. Bot zu Server einladen (mit noetigen Scopes)
# 4. openclaw channels login → Discord → Token eingeben
```

---

## AI-MODELL PROVIDER

| Provider | Setup | Empfehlung |
|----------|-------|------------|
| Anthropic (Claude) | API-Key | EMPFOHLEN (staerkstes Instruction-Following) |
| OpenAI (GPT) | API-Key | Gut |
| Ollama (lokal) | Lokal installieren | Fuer volle Privatsphaere |
| OpenRouter | API-Key | Zugriff auf viele Modelle |
| Mistral | API-Key | Europaeische Alternative |

### Anthropic einrichten
```bash
# Via Onboarding:
openclaw onboard --anthropic-api-key "sk-ant-..."

# Oder in ~/.openclaw/openclaw.json:
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "anthropic/claude-opus-4-6"
      }
    }
  }
}
```

### Ollama (lokale Modelle, kein API-Key noetig)
```bash
# Ollama installieren:
brew install ollama

# Modell herunterladen:
ollama pull llama3

# In openclaw.json:
# "primary": "ollama/llama3"
```

---

## PRODUKTIVITAETS-INTEGRATIONEN

| Integration | Was es kann |
|-------------|-------------|
| Apple Notes | Notizen lesen/schreiben |
| Apple Reminders | Erinnerungen verwalten |
| Obsidian | Markdown-Vault steuern |
| Notion | Datenbanken und Seiten |
| GitHub | Repos, Issues, PRs |
| Gmail | Mails lesen/senden |
| Google Calendar | Termine verwalten |
| Things 3 | Aufgaben |

---

## CLAWHUB SKILLS

```bash
# CLI installieren
npm i -g clawhub

# Suchen
clawhub search "spotify"
clawhub search "calendar"
clawhub search "github"

# Installieren
clawhub install <slug>

# IMMER nach Installation:
openclaw security audit --fix

# Auf clawhub.ai: web-browserbasierteSuche
```

**Sicherheit:**
- ClawHub: VirusTotal-gescannt ✓
- GitHub/Discord/Community: NICHT gescannt — Vorsicht!
- Nach jeder Installation Security Audit laufen lassen

---

## SMART HOME

- Philips Hue (Lichter)
- Home Assistant (Zentralsteuerung)
- 8Sleep (Schlafmonitor)

---

## REMOTE-ZUGRIFF (Mac als Node)

```bash
# Tailscale installieren:
brew install tailscale
sudo tailscaled

# Tailscale-Account verbinden:
tailscale up

# OpenClaw Companion App: "Remote Mode" aktivieren
# → SSH/Tailscale-Ziel angeben
# → Pairing genehmigen:
openclaw devices approve <requestId>
```

---

> Quelle: docs.openclaw.ai/integrations | Stand: 2026-03-11
