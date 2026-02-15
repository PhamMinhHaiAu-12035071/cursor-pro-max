#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  echo "Usage: ./install.sh <target-directory>"
  echo "Example: ./install.sh /path/to/your-project"
  echo ""
  echo "Copies .cursor/commands, .cursor/rules, .claude/skills, and GLOBAL_RULE.md into target."
  echo "Safe to re-run (updates existing files)."
  exit 0
fi

TARGET="${1:?Usage: ./install.sh <target-directory>}"

if [[ ! -d "$TARGET" ]]; then
  echo "Error: Directory not found: $TARGET"
  exit 1
fi

if [[ "$(cd "$TARGET" && pwd)" == "$SCRIPT_DIR" ]]; then
  echo "Error: Target cannot be the source directory itself."
  exit 1
fi

# Commands
mkdir -p "$TARGET/.cursor/commands"
cp "$SCRIPT_DIR"/.cursor/commands/*.md "$TARGET/.cursor/commands/"
echo "Copied .cursor/commands/"

# Rules
mkdir -p "$TARGET/.cursor/rules"
cp "$SCRIPT_DIR"/.cursor/rules/*.mdc "$TARGET/.cursor/rules/"
echo "Copied .cursor/rules/"

# Skills
mkdir -p "$TARGET/.claude/skills"
cp -R "$SCRIPT_DIR"/.claude/skills/* "$TARGET/.claude/skills/"
echo "Copied .claude/skills/"

# Global rule
cp "$SCRIPT_DIR"/GLOBAL_RULE.md "$TARGET/GLOBAL_RULE.md"
echo "Copied GLOBAL_RULE.md"

echo ""
echo "Done! Restart Cursor IDE to load changes."
