#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST_FILE=".cursor-pro-max-manifest"

# Items removed from cursor-pro-max that should be cleaned up at target.
# Add entries here when skills, commands, or rules are permanently removed.
DEPRECATED_ITEMS=(
  ".claude/skills/dev-dao"
  ".claude/skills/humanizer"
  ".cursor/commands/dev-dao-architecture.md"
)

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  echo "Usage: ./install.sh <target-directory>"
  echo "Example: ./install.sh /path/to/your-project"
  echo ""
  echo "Copies .cursor/commands, .cursor/rules, .claude/skills, and GLOBAL_RULE.md into target."
  echo "Also cleans up deprecated items from previous installations."
  echo "Safe to re-run (updates existing files, removes deprecated ones)."
  echo ""
  echo "User-created files at the target are never modified or removed."
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

# ─── Build list of current source items ─────────────────────────────────────
current_items=()

for f in "$SCRIPT_DIR"/.cursor/commands/*.md; do
  [[ -f "$f" ]] && current_items+=(".cursor/commands/$(basename "$f")")
done

for f in "$SCRIPT_DIR"/.cursor/rules/*.mdc; do
  [[ -f "$f" ]] && current_items+=(".cursor/rules/$(basename "$f")")
done

for d in "$SCRIPT_DIR"/.claude/skills/*/; do
  [[ -d "$d" ]] && current_items+=(".claude/skills/$(basename "$d")")
done

current_items+=("GLOBAL_RULE.md")

# ─── Cleanup deprecated items (hardcoded migration list) ────────────────────
echo "Checking for deprecated items..."
deprecated_count=0

for item in "${DEPRECATED_ITEMS[@]}"; do
  target_path="$TARGET/$item"
  if [[ -e "$target_path" ]]; then
    rm -rf "$target_path"
    echo "  Removed deprecated: $item"
    ((deprecated_count++)) || true
  fi
done

# ─── Cleanup items from old manifest no longer in source ────────────────────
if [[ -f "$TARGET/$MANIFEST_FILE" ]]; then
  while IFS= read -r old_item; do
    [[ -z "$old_item" ]] && continue
    found=false
    for current in "${current_items[@]}"; do
      if [[ "$current" == "$old_item" ]]; then
        found=true
        break
      fi
    done
    if [[ "$found" == false ]]; then
      target_path="$TARGET/$old_item"
      if [[ -e "$target_path" ]]; then
        rm -rf "$target_path"
        echo "  Removed deprecated: $old_item"
        ((deprecated_count++)) || true
      fi
    fi
  done < "$TARGET/$MANIFEST_FILE"
fi

if [[ $deprecated_count -eq 0 ]]; then
  echo "  No deprecated items found."
else
  echo "  Cleaned up $deprecated_count deprecated item(s)."
fi
echo ""

# ─── Install current items ──────────────────────────────────────────────────

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

# ─── Write manifest for future cleanup ──────────────────────────────────────
printf '%s\n' "${current_items[@]}" > "$TARGET/$MANIFEST_FILE"

echo ""
echo "Done! Restart Cursor IDE to load changes."
