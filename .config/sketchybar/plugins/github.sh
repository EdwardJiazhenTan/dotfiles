#!/bin/bash

COUNT=$(/opt/homebrew/bin/gh api notifications --jq 'length' 2>/dev/null)

if [ -z "$COUNT" ] || ! [[ "$COUNT" =~ ^[0-9]+$ ]]; then
  COUNT=0
fi

sketchybar --set $NAME label="$COUNT" icon.drawing=on
