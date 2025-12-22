#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"
data=$("$PLUGIN_DIR/system_data.sh")

cpu_usage=$(echo "$data" | grep -o '"cpu_usage":[[:space:]]*"[0-9.]*"' | grep -o '[0-9.]*')

if [ -n "$cpu_usage" ]; then
  sketchybar --set "$NAME" label="$(printf "%.0f" "$cpu_usage")%" drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
