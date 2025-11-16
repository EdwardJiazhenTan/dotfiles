#!/bin/sh

# Get now playing info from macOS Music
TITLE=$(osascript -e 'tell application "Music" to if player state is playing then name of current track' 2>/dev/null)
ARTIST=$(osascript -e 'tell application "Music" to if player state is playing then artist of current track' 2>/dev/null)

# If Music isn't playing, try Spotify
if [ -z "$TITLE" ]; then
  TITLE=$(osascript -e 'tell application "Spotify" to if player state is playing then name of current track' 2>/dev/null)
  ARTIST=$(osascript -e 'tell application "Spotify" to if player state is playing then artist of current track' 2>/dev/null)
fi

# Build the display string
if [ -n "$TITLE" ] && [ -n "$ARTIST" ]; then
  DISPLAY="$TITLE - $ARTIST"
elif [ -n "$TITLE" ]; then
  DISPLAY="$TITLE"
else
  DISPLAY=""
fi

# Truncate if too long
if [ ${#DISPLAY} -gt 50 ]; then
  DISPLAY="${DISPLAY:0:47}..."
fi

sketchybar --set "$NAME" label="$DISPLAY"
