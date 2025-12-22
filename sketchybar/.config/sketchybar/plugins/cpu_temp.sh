#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"
data=$("$PLUGIN_DIR/system_data.sh")

cpu_temp=$(echo "$data" | grep -o '"cpu_temp":[[:space:]]*"[0-9.]*"' | grep -o '[0-9.]*')

if [ -n "$cpu_temp" ]; then
  sketchybar --set "$NAME" label="$(printf "%.0f" "$cpu_temp")°C" drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
