#!/bin/bash

COUNT=$(osascript -e 'tell application "Mail" to get unread count of inbox' 2>/dev/null)

if [ -z "$COUNT" ] || ! [[ "$COUNT" =~ ^[0-9]+$ ]]; then
  COUNT=0
fi

sketchybar --set $NAME label="$COUNT" icon.drawing=on
