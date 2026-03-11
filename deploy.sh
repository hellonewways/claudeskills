#!/bin/bash
# deploy.sh — Links your-context/ files to OpenClaw workspace
#
# Run from the repo root: bash deploy.sh
# Fill in your-context/ first — see your-context/README.md

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CONTEXT_DIR="$REPO_DIR/your-context"
WORKSPACE="$HOME/.openclaw/workspace"

# Check your-context/ exists
if [ ! -d "$CONTEXT_DIR" ]; then
  echo "Error: your-context/ folder not found."
  echo "Create it and fill in your context files first."
  echo "See your-context/README.md for instructions."
  exit 1
fi

mkdir -p "$WORKSPACE"

echo "Deploying context to $WORKSPACE ..."
echo ""

FILES=(SOUL IDENTITY MEMORY USER BOOT HEARTBEAT)
DEPLOYED=0

for file in "${FILES[@]}"; do
  src="$CONTEXT_DIR/$file.md"
  dst="$WORKSPACE/$file.md"
  if [ -f "$src" ]; then
    ln -sf "$src" "$dst"
    echo "  v $file.md"
    DEPLOYED=$((DEPLOYED + 1))
  else
    echo "  - $file.md (not found, skipping)"
  fi
done

echo ""
echo "Deployed $DEPLOYED file(s)."
echo ""
echo "Next: restart your OpenClaw gateway to apply changes."
echo "  launchctl kickstart -k gui/\$UID/ai.openclaw.gateway"
