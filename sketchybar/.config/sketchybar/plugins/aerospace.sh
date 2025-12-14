#!/usr/bin/env bash
# AeroSpace Workspace Indicator - Optimized for performance
# Displays the currently focused AeroSpace workspace with a custom icon
#
# Workspace mappings:
# A = AI, W = Web, T = Terminal, P = Productivity, S = Social Media
# G = Gaming, X = Extra, C = Coding, V = Video, B = Browser, M = Music

set -euo pipefail

# Atomic locking using mkdir (atomic on all UNIX systems)
# This prevents race conditions during concurrent executions
LOCK_DIR="/tmp/sketchybar_aerospace.lock"
TIMESTAMP_FILE="$LOCK_DIR/timestamp"

# Try to create lock directory atomically
# If it fails, another instance is running
if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  # Check if lock is stale (older than 2 seconds = stuck process)
  if [ -d "$LOCK_DIR" ]; then
    LOCK_AGE=$(($(date +%s) - $(stat -f %m "$LOCK_DIR" 2>/dev/null || echo 0)))
    if [ "$LOCK_AGE" -gt 2 ]; then
      # Stale lock, remove it
      rm -rf "$LOCK_DIR" 2>/dev/null || true
      # Try again
      mkdir "$LOCK_DIR" 2>/dev/null || exit 0
    else
      # Fresh lock, another instance is running
      exit 0
    fi
  else
    exit 0
  fi
fi

# Ensure lock is removed on exit
trap 'rm -rf "$LOCK_DIR" 2>/dev/null' EXIT

# Debounce: check if we ran too recently (50ms)
DEBOUNCE_MS=50
LAST_RUN=0

if [ -f "$TIMESTAMP_FILE" ]; then
  LAST_RUN=$(cat "$TIMESTAMP_FILE" 2>/dev/null || echo "0")
fi

CURRENT_MS=$(($(date +%s) * 1000 + $(date +%N) / 1000000))
TIME_SINCE_LAST=$((CURRENT_MS - LAST_RUN))

if [ "$LAST_RUN" -gt 0 ] && [ "$TIME_SINCE_LAST" -lt "$DEBOUNCE_MS" ]; then
  # Too soon since last execution, skip
  exit 0
fi

# Record current execution time
echo "$CURRENT_MS" >"$TIMESTAMP_FILE"

# Get the currently focused workspace from aerospace
WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null || echo "?")

# Extract just the first letter
LETTER="${WORKSPACE:0:1}"

# Map workspace letters to icons (uppercase)
case "$LETTER" in
A) ICON="󰚩" ;;       # AI
W) ICON="" ;;       # Web
T) ICON="󰆍" ;;       # Terminal
P) ICON="󰈙" ;;       # Productivity
S) ICON="󰭹" ;;       # Social Media
G) ICON="󰊴" ;;       # Gaming
X) ICON="󰿨" ;;       # Extra
C) ICON="󰘦" ;;       # Coding
V) ICON="󰕧" ;;       # Video
M) ICON="󰎆" ;;       # Music
*) ICON="$LETTER" ;; # Fallback to letter
esac

# Update the sketchybar item with both icon and letter
sketchybar --set "${NAME:-aerospace}" icon="$ICON" label="$LETTER" 2>/dev/null || true
