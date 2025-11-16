#!/usr/bin/env bash

# Get the currently focused workspace from aerospace
WORKSPACE=$(aerospace list-workspaces --focused)

# Extract just the first letter
LETTER="${WORKSPACE:0:1}"

# Update the sketchybar item with the current workspace letter
sketchybar --set aerospace label="$LETTER"
