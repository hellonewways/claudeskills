# HEARTBEAT.md — Periodic Monitoring Tasks
# The agent runs these checks automatically on schedule.
# Remove sections you don't need. Keep what's useful.

---

## Daily Morning Check (recommended: 08:00)

- Run `openclaw doctor` and report any warnings
- Check `openclaw health` — flag if anything is degraded
- Summarize today's calendar if calendar integration is active
- Check for unread high-priority messages

## Daily Security Check (recommended: 12:00)

- Run `openclaw security audit`
- If issues found: write summary to MEMORY.md, notify via chat
- Check that gateway is bound to loopback only
- Verify no unknown devices are paired: `openclaw devices list`

## Daily Log Review (recommended: 18:00)

- Scan today's logs for ERROR or FATAL entries: `openclaw logs`
- Summarize any recurring errors
- If new unknown errors: write to MEMORY.md for review
- Report summary via chat if issues were found

## Weekly Maintenance (recommended: Monday 09:00)

- Run `openclaw security audit --deep`
- Check for available updates: `openclaw update --check`
- Review exec approvals list — flag any unexpected entries
- Review paired devices — remove any unknown ones
- Write weekly health summary to MEMORY.md

## On Anomaly (event-driven)

- If gateway restarts unexpectedly: notify immediately via chat
- If rate limit errors persist: notify and suggest model fallback
- If unknown sender attempts DM: log and report

---

# SELF-IMPROVEMENT LOOP:
# When the agent finds a recurring issue it cannot solve alone,
# it writes a structured note to MEMORY.md:
#
#   ## Issue [DATE]
#   Problem: [what happened]
#   Frequency: [how often]
#   Impact: [what it affects]
#   Attempted: [what was tried]
#   Needs: [what human input or config change is required]
#
# The human (or an external Claude Code session) reviews and resolves.
