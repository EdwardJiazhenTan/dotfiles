#!/usr/bin/env bash
set -euo pipefail

# Get current audio output device
DEVICE=$(SwitchAudioSource -c 2>/dev/null || echo "Unknown")

case "$DEVICE" in
  *"MacBook Pro Speakers"*) LABEL="MBP" ;;
  *"张可儿Olivia的AirPods"*) LABEL="AirPods" ;;
  *"HK SoundStick 4"*) LABEL="HK" ;;
  "Unknown") LABEL="?" ;;
  *) LABEL="$DEVICE" ;;
esac

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

  if [ ${#MEDIA} -gt 50 ]; then
    MEDIA="${MEDIA:0:47}..."
  fi

  if [ -n "$MEDIA" ]; then
    sketchybar --set "$NAME" label="$LABEL | $MEDIA" 2>/dev/null || true
    exit 0
  fi
fi

sketchybar --set "$NAME" label="$LABEL" 2>/dev/null || true
