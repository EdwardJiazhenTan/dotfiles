#!/bin/bash

# Fetch the badge label from the Slack Dock icon
SLACK_COUNT=$(osascript -e 'tell application "System Events" to tell process "Dock" to get value of attribute "AXStatusLabel" of UI element "Slack" of list 1' 2>/dev/null)

# If the count is "missing value", empty, or not a number, set to 0
if [ "$SLACK_COUNT" = "missing value" ] || [ -z "$SLACK_COUNT" ] || ! [[ "$SLACK_COUNT" =~ ^[0-9]+$ ]]; then
  SLACK_COUNT=0
fi

# Update Sketchybar
sketchybar --set $NAME label="$SLACK_COUNT" icon.drawing=on
