# MONITORING.md — KI überwacht KI
# Architecture: How this agent monitors and improves itself

---

## The Loop

```
OpenClaw (Agent)
    │
    ├── HEARTBEAT.md runs on schedule
    │       ├── openclaw doctor
    │       ├── openclaw security audit
    │       ├── openclaw health
    │       └── log review
    │
    ├── Issues found?
    │       ├── Minor → agent fixes autonomously (config, restart)
    │       ├── Medium → writes structured note to MEMORY.md + notifies user
    │       └── Critical → immediate chat notification + halts risky ops
    │
    └── Human / Claude Code reviews MEMORY.md
            └── Claude Code: reads logs, edits config, updates docs, redeploys
```

---

## Two Layers of Oversight

### Layer 1 — OpenClaw watches itself
- HEARTBEAT.md runs automated checks
- Agent can restart gateway, update allowlists, rotate sessions
- Writes issues it cannot solve to MEMORY.md
- Notifies user via chat channel

### Layer 2 — Claude Code watches OpenClaw
- External review of logs, config, and MEMORY.md
- Can edit any file, run any diagnostic, update config
- Triggered by user or by OpenClaw's own escalation
- Updates docs and template when patterns are found

---

## What the Agent Can Fix Alone

| Issue | Autonomous Fix |
|-------|---------------|
| Gateway crashed | `openclaw gateway restart` |
| Rate limit hit | Switch to fallback model |
| Unknown device paired | Remove via `openclaw devices remove` |
| Stale session | `openclaw sessions clear` |
| Exec approval pending | Alert user, do not self-approve |

## What Requires Human or Claude Code

| Issue | Action |
|-------|--------|
| Config file changes | Claude Code edits and restarts |
| Security policy update | Human reviews, Claude Code applies |
| New skill installation | Human approves, Claude Code installs + audits |
| Credential rotation | Human rotates, Claude Code updates config |
| Template/doc improvements | Claude Code updates and commits |

---

## Self-Improvement Protocol

When Claude Code identifies a recurring pattern or improvement:

1. **Document** — write the issue and fix to the relevant `.md` file
2. **Apply** — make the change in config or code
3. **Test** — run `openclaw doctor` + `openclaw health`
4. **Update template** — if the fix is universal, update this template
5. **Commit** — push improvement to the public GitHub template repo

This means the template gets better over time from real-world use.

---

## Escalation Levels

| Level | Trigger | Response |
|-------|---------|---------|
| INFO | Routine check passed | Write to MEMORY.md, silent |
| WARN | Non-critical anomaly | Write to MEMORY.md, daily summary |
| ERROR | Service degraded | Immediate chat notification |
| CRITICAL | Security event / data risk | Immediate notification + stop risky operations |

---

## Recommended Cron Schedule

```bash
# Install via:
openclaw cron add "daily-check" "0 8 * * *" "run HEARTBEAT morning check"
openclaw cron add "security"    "0 12 * * *" "run security audit"
openclaw cron add "log-review"  "0 18 * * *" "review today's logs"
openclaw cron add "weekly"      "0 9 * * 1"  "run weekly maintenance"
```

---

## Notes

- The agent does NOT self-approve security policy changes — always human-in-the-loop
- Claude Code has terminal access and can act as the "senior engineer" layer
- This architecture mirrors how OpenClaw itself is built: agents checking agents
