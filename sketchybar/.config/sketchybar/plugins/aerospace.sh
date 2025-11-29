#!/usr/bin/env bash

# Get the currently focused workspace from aerospace
WORKSPACE=$(aerospace list-workspaces --focused)

# Extract just the first letter
LETTER="${WORKSPACE:0:1}"

# Map workspace letters to icons (uppercase)
case "$LETTER" in
  A) ICON="󰚩" ;;  # AI
  W) ICON="󰖟" ;;  # Web
  T) ICON="󰆍" ;;  # Terminal
  P) ICON="󰈙" ;;  # Productivity
  S) ICON="󰭹" ;;  # Social Media
  G) ICON="󰊴" ;;  # Gaming
  X) ICON="󰿨" ;;  # Extra
  C) ICON="󰨞" ;;  # Coding
  V) ICON="󰕧" ;;  # Video
  B) ICON="󰈹" ;;  # Browser
  M) ICON="󰎆" ;;  # Music
  *) ICON="$LETTER" ;;  # Fallback to letter
esac

# Update the sketchybar item with both icon and letter
sketchybar --set aerospace icon="$ICON" label="$LETTER"
