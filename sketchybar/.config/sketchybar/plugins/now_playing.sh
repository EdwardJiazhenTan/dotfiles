#!/usr/bin/env bash
set -euo pipefail

# Get Spotify playback info using AppleScript
STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null || echo "stopped")

if [ "$STATE" = "playing" ]; then
  TITLE=$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null || echo "")
  ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track' 2>/dev/null || echo "")

  # Build media string
  if [ -n "$TITLE" ] && [ -n "$ARTIST" ]; then
    MEDIA="$TITLE - $ARTIST"
  elif [ -n "$TITLE" ]; then
    MEDIA="$TITLE"
  else
    MEDIA=""
  fi

  # Truncate if too long
  if [ ${#MEDIA} -gt 50 ]; then
    MEDIA="${MEDIA:0:47}..."
  fi

  sketchybar --set "$NAME" label="$MEDIA" drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
