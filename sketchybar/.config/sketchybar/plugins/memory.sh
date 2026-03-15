#!/usr/bin/env bash
set -euo pipefail

PAGES=$(vm_stat 2>/dev/null | awk '
  /Pages active/   { active = $3 }
  /Pages wired/    { wired = $4 }
  /Pages compressed/ { compressed = $3 }
  END { gsub(/\./, "", active); gsub(/\./, "", wired); gsub(/\./, "", compressed); print active + wired + compressed }
')

TOTAL=$(sysctl -n hw.memsize 2>/dev/null)
PAGE_SIZE=16384

if [ -n "$PAGES" ] && [ -n "$TOTAL" ]; then
  USED_BYTES=$((PAGES * PAGE_SIZE))
  PCT=$(awk "BEGIN {printf \"%.0f\", ($USED_BYTES / $TOTAL) * 100}")
  sketchybar --set "$NAME" label="${PCT}%" 2>/dev/null || true
else
  sketchybar --set "$NAME" label="?" 2>/dev/null || true
fi
