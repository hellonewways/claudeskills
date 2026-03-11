#!/bin/bash
# deploy.sh — Deploy this template into your OpenClaw workspace
# Usage: bash deploy.sh
# Run from inside the Openclaw Template folder

TEMPLATE_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE="$HOME/.openclaw/workspace"

echo "Deploying OpenClaw template..."
echo "From: $TEMPLATE_DIR"
echo "To:   $WORKSPACE"
echo ""

mkdir -p "$WORKSPACE/memory"

files=("SOUL.md" "IDENTITY.md" "MEMORY.md" "BOOT.md" "HEARTBEAT.md" "USER.md")

for f in "${files[@]}"; do
  if [ -f "$TEMPLATE_DIR/$f" ]; then
    ln -sf "$TEMPLATE_DIR/$f" "$WORKSPACE/$f"
    echo "  Linked: $f"
  else
    echo "  Skipped (not found): $f"
  fi
done

echo ""
echo "Done. Restart gateway to apply:"
echo "  openclaw gateway restart"
