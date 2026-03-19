#!/usr/bin/env bash
set -euo pipefail

# Check if Spotify has a track (playing or paused)
STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null || echo "stopped")

if [ "$STATE" = "playing" ] || [ "$STATE" = "paused" ]; then
  TITLE=$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null || echo "")
  ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track' 2>/dev/null || echo "")

  if [ -n "$TITLE" ] && [ -n "$ARTIST" ]; then
    MEDIA="$TITLE - $ARTIST"
  elif [ -n "$TITLE" ]; then
    MEDIA="$TITLE"
  else
    MEDIA=""
  fi

  if [ -n "$MEDIA" ]; then
    CURRENT=$(sketchybar --query "$NAME" 2>/dev/null | jq -r '.label.value // empty')
    if [ "$CURRENT" != "$MEDIA" ]; then
      sketchybar --set "$NAME" label="$MEDIA" drawing=on 2>/dev/null || true
    elif [ "$(sketchybar --query "$NAME" 2>/dev/null | jq -r '.geometry.drawing // empty')" != "on" ]; then
      sketchybar --set "$NAME" drawing=on 2>/dev/null || true
    fi
    exit 0
  fi
fi

sketchybar --set "$NAME" drawing=off 2>/dev/null || true
