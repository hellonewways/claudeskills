# OpenClaw — Security Guide
# Quelle: docs.openclaw.ai/gateway/security | Stand: 2026-03-11

---

## SICHERHEITSMODELL

OpenClaw nutzt ein "Personal Assistant Trust Model":
- EIN User / EIN Trust-Boundary pro Gateway
- Fuer mehrere Nutzer: getrennte Gateways auf getrennten Hosts
- Nie multi-tenant auf einem Gateway!

---

## SOFORT-AUDIT

```bash
openclaw security audit           # Basis-Check
openclaw security audit --deep    # Live-Probing
openclaw security audit --fix     # Automatische Korrekturen
```

Regelmaessig ausfuehren, besonders nach:
- Konfigurationsaenderungen
- Netzwerk-Exposition-Aenderungen
- Updates

---

## KRITISCHE EINSTELLUNGEN

### 1. Gateway NUR lokal binden
```json5
{
  "gateway": {
    "bind": "loopback"   // NIEMALS "0.0.0.0" ohne Auth!
  }
}
```

### 2. Token-Authentifizierung aktivieren
```json5
{
  "gateway": {
    "auth": {
      "mode": "token"
    }
  }
}
```

### 3. DM-Richtlinie (wer darf schreiben?)
```json5
{
  "channels": {
    "whatsapp": {
      "dmPolicy": "pairing",       // Standard: unbekannte bekommen Einmal-Code
      // "allowlist" = nur erlaubte Nummern
      // "open" = alle (GEFAEHRLICH!)
      "allowFrom": ["+4179..."]    // Erlaubte Nummern
    }
  }
}
```

### 4. Gruppen: Mention erzwingen
```json5
{
  "channels": {
    "whatsapp": {
      "groups": {
        "requireMention": true,
        "mentionPattern": "@openclaw"
      }
    }
  }
}
```

### 5. Exec-Approvals (Shell-Ausfuehrung)
```json5
// in exec-approvals.json oder via Settings → Exec Approvals:
{
  "mode": "allowlist",        // Nur genehmigte Befehle
  "ask": "on-miss",          // Nachfragen bei unbekannten
  "allowlist": []            // Leer = nichts erlaubt
}
```

### 6. Secrets aus Logs redaktieren
```json5
{
  "logging": {
    "redactSensitive": "tools"
  }
}
```

---

## DATEI-BERECHTIGUNGEN

Manuell sicherstellen:
```bash
chmod 600 ~/.openclaw/openclaw.json
chmod 600 ~/.openclaw/credentials/**/*.json
chmod 700 ~/.openclaw/credentials/
chmod 700 ~/.openclaw/agents/
```

Sensitive Dateipfade:
| Datei | Inhalt |
|-------|--------|
| `~/.openclaw/credentials/whatsapp/<id>/creds.json` | WhatsApp-Session |
| `~/.openclaw/credentials/<channel>-allowFrom.json` | Erlaubte Sender |
| `~/.openclaw/agents/<id>/agent/auth-profiles.json` | Modell-Auth |
| `~/.openclaw/agents/<id>/sessions/*.jsonl` | Chat-Transkripte |

---

## PROMPT INJECTION — WICHTIGSTE BEDROHUNG

> "Prompt injection ist ein industrie-weites ungloestes Problem."
> — docs.openclaw.ai

Was das ist: Angreifer formuliert Nachricht so, dass das KI-Modell
manipuliert wird, ungewollte Aktionen auszufuehren.

**Schutz:**
- Starkes, aktuelles Modell verwenden (claude-opus-4-6!)
- Altere/kleinere Modelle sind VIEL anfaelliger
- DMs per Pairing/Allowlist sichern
- Gruppen: Mention erzwingen
- Links und eingefuegte Anweisungen als potenziell feindlich behandeln
- Sandboxing fuer heikle Tools aktivieren

---

## PER-AGENT PROFILE (empfohlen)

Verschiedene Agents fuer verschiedene Vertrauensstufen:

| Agent | Konfiguration |
|-------|--------------|
| Persoenlicher Agent | Voller Zugriff, kein Sandbox |
| Familie/Arbeits-Agent | Sandbox, nur lesend |
| Oeffentlicher Agent | Sandbox, kein Filesystem/Shell |

---

## REMOTE-ZUGRIFF

- Bevorzuge: **Tailscale Serve** (sicherer Tunnel)
- Vermeide: Direktes LAN-Binden ohne Auth
- SSH-Tunnel Alternative:
```bash
ssh -N -L 18789:localhost:18789 user@remote-host
```

---

## mDNS-LEAK verhindern

mDNS kann Dateipfade und SSH-Infos leaken:
```json5
{
  "gateway": {
    "mdns": "minimal"   // Statt default-Modus
  }
}
```

---

## INCIDENT RESPONSE

1. **Eindaemmen:**
   ```bash
   # Gateway stoppen
   launchctl bootout gui/$UID/ai.openclaw.gateway
   # Bind auf loopback setzen, riskante Channels deaktivieren
   ```

2. **Rotieren:**
   - Gateway-Auth-Token neu generieren
   - Channel-Credentials erneuern
   - Provider-API-Key wechseln (Anthropic Console)

3. **Audit:**
   ```bash
   openclaw logs --follow
   openclaw security audit --deep
   # Transkripte pruefen: ~/.openclaw/agents/*/sessions/
   ```

---

## SICHERHEITS-KONTAKT

Vulnerabilities melden an:
**security@openclaw.ai**
(Mit: genauen Code-Pfaden, Version, Reproduktionsschritte)

---

## COMMUNITY-CODE — WARNUNG

Wenn du Code/Skills aus der Community verwendest (GitHub, Discord etc.):
- NUR von verifizierten Quellen (openclaw.ai, docs.openclaw.ai, ClawHub)
- ClawHub-Skills werden per VirusTotal gescannt
- Community-Code (GitHub Issues, Discord, Reddit) = unvetted, Vorsicht!
- Niemals fremden Code direkt ausfuehren ohne Lesen + Verstehen
- Prompt Injection kann auch in Skill-Code versteckt sein

---

> Quelle: docs.openclaw.ai/gateway/security | Stand: 2026-03-11
