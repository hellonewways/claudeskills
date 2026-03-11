# OpenClaw — Roadmap & Business Context Setup
# Stand: 2026-03-11

---

## BUSINESS CONTEXT ORDNER — KRITISCHE BEWERTUNG

**Idee:** Ein persoenlicher Ordner (z.B. `~/Business Context/`) mit allen
Agent-Identitaets- und Wissensdateien, der bei Install/Update/Migration
einfach in den OpenClaw-Workspace kopiert wird.

**Urteil: Ja — macht Sinn. Unbedingt umsetzen.**

### Warum es funktioniert
OpenClaw speichert die "Seele" des Agents in Textdateien:

| Datei | Was sie steuert | Aenderbar? |
|-------|-----------------|-----------|
| `SOUL.md` | Persoenlichkeit, Tonalitaet, Grundinstruktionen | Ja |
| `IDENTITY.md` | Wer ist der Agent, sein Name, seine Rolle | Ja |
| `MEMORY.md` | Dauerhaftes Wissen ueber dich und dein Business | Ja |
| `BOOT.md` | Was der Agent beim Start tut | Ja |
| `BOOTSTRAP.md` | Initialisierungslogik | Ja |
| `HEARTBEAT.md` | Regelmaessige Hintergrund-Tasks | Ja |
| `TOOLS.md` | Erlaubte Tools und Policies | Ja |
| `USER.md` | Dein Nutzerprofil fuer den Agent | Ja |

Alle Dateien liegen in: `~/.openclaw/workspace/` (oder Agent-spezifisch)

### Kritische Punkte (Gegenargumente)
- `MEMORY.md` kann sensible Business-Infos enthalten → **privates Repo, niemals public**
- Soul-Dateien zeigen einem Angreifer genau, wie dein Agent denkt → **Zugriffsschutz**
- Keine API-Keys oder Credentials in diesen Dateien speichern (falsche Schicht)
- Zu viele Instruktionen in SOUL.md = schlechtere Model-Performance → lean halten

---

## SETUP: BUSINESS CONTEXT ORDNER

### Struktur (Empfehlung)

```
~/Business Context/           <- dein persoenlicher Kontext-Ordner
├── openclaw/
│   ├── SOUL.md               <- Persoenlichkeit, Stil, Grundregeln
│   ├── IDENTITY.md           <- Name, Rolle, Kontext des Agents
│   ├── MEMORY.md             <- Dauerhaftes Business-Wissen
│   ├── BOOT.md               <- Startup-Tasks
│   ├── HEARTBEAT.md          <- Regelmaessige Tasks (Daily Brief etc.)
│   └── USER.md               <- Dein Profil fuer den Agent
└── skills/                   <- Eigene Custom Skills
    └── ...
```

### Deploy-Befehl (nach Install/Update/Migration)
```bash
# Einmalig: Symlinks setzen (besser als kopieren)
ln -sf ~/Business\ Context/openclaw/SOUL.md ~/.openclaw/workspace/SOUL.md
ln -sf ~/Business\ Context/openclaw/IDENTITY.md ~/.openclaw/workspace/IDENTITY.md
ln -sf ~/Business\ Context/openclaw/MEMORY.md ~/.openclaw/workspace/MEMORY.md
ln -sf ~/Business\ Context/openclaw/BOOT.md ~/.openclaw/workspace/BOOT.md
ln -sf ~/Business\ Context/openclaw/HEARTBEAT.md ~/.openclaw/workspace/HEARTBEAT.md
ln -sf ~/Business\ Context/openclaw/USER.md ~/.openclaw/workspace/USER.md

# Alternativ: Skript (deploy-context.sh)
```

### Als Script (deploy-context.sh)
```bash
#!/bin/bash
# deploy-context.sh — Business Context in OpenClaw deployen
# Ausfuehren: bash ~/Business\ Context/deploy-context.sh

CONTEXT_DIR="$HOME/Business Context/openclaw"
WORKSPACE="$HOME/.openclaw/workspace"

mkdir -p "$WORKSPACE"

files=("SOUL.md" "IDENTITY.md" "MEMORY.md" "BOOT.md" "HEARTBEAT.md" "USER.md")

for f in "${files[@]}"; do
  if [ -f "$CONTEXT_DIR/$f" ]; then
    ln -sf "$CONTEXT_DIR/$f" "$WORKSPACE/$f"
    echo "Linked: $f"
  else
    echo "Skipped (not found): $f"
  fi
done

echo "Done. Restart gateway:"
echo "openclaw gateway restart"
```

### Versionskontrolle (privates Git-Repo, dringend empfohlen)
```bash
cd ~/Business\ Context
git init
git remote add origin git@github.com:<dein-privates-repo>.git

# .gitignore
echo "*.key" >> .gitignore
echo "*.token" >> .gitignore
echo "*.env" >> .gitignore

git add openclaw/
git commit -m "Initial business context"
git push -u origin main
```

**Niemals committen:** API-Keys, Credentials, `.openclaw/credentials/`

---

## ROADMAP — PHASEN

### Phase 1: Grundinstallation (Jetzt)
- [ ] Node.js 22+ installieren
- [ ] OpenClaw installieren (One-Liner)
- [ ] Onboarding mit Anthropic-Key
- [ ] Ersten Channel verbinden (WhatsApp empfohlen)
- [ ] Gateway als Daemon installieren
- [ ] macOS Companion App installieren
- [ ] Diagnose: `openclaw doctor`

### Phase 2: Haertung (direkt danach)
- [ ] Security Audit: `openclaw security audit`
- [ ] Gateway auf loopback binden
- [ ] Token-Auth aktivieren
- [ ] DM-Policy auf "pairing" oder "allowlist"
- [ ] Exec Approvals konfigurieren
- [ ] Dateirechte pruefen (chmod 600/700)

### Phase 3: Personalisierung
- [ ] Business Context Ordner aufsetzen
- [ ] SOUL.md schreiben (Persoenlichkeit, Tonalitaet)
- [ ] IDENTITY.md schreiben (Name, Rolle)
- [ ] MEMORY.md mit Business-Wissen befuellen
- [ ] HEARTBEAT.md (Daily Brief, Morgenroutine)
- [ ] deploy-context.sh erstellen und testen
- [ ] Privates Git-Repo fuer Business Context

### Phase 4: Integrationen
- [ ] Zweiten Channel verbinden (Telegram oder iMessage)
- [ ] Gmail-Integration
- [ ] Kalender-Integration
- [ ] ClawHub Skills installieren (nach Security Audit)
- [ ] Tailscale fuer sicheren Remote-Zugriff

### Phase 5: Automatisierung
- [ ] Cron-Jobs / Heartbeat aktivieren
- [ ] Daily Brief konfigurieren
- [ ] Custom Skills schreiben
- [ ] Multi-Agent Setup (optional)

---

## WENN DU DEN BUSINESS CONTEXT ORDNER GIBST

Sobald du mir den Ordner gibst, kann ich:

1. `SOUL.md` — Agent-Persoenlichkeit auf dich zuschneiden
2. `IDENTITY.md` — Namen und Rolle des Agents setzen
3. `MEMORY.md` — Wichtiges Business-Wissen eintragen
4. `HEARTBEAT.md` — Deine Morgenroutine / Daily Brief konfigurieren
5. Alle Dateien per Symlink in den Workspace deployen
6. `openclaw gateway restart` — fertig

Das dauert <5 Minuten und dein Agent weiss sofort alles ueber dich.

---

> Stand: 2026-03-11 | Quelle Dateistruktur: docs.openclaw.ai/reference/templates/
