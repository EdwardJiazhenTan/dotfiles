#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"
data=$("$PLUGIN_DIR/system_data.sh")

mem_usage=$(echo "$data" | grep -o '"mem_usage":[[:space:]]*"[0-9.]*"' | grep -o '[0-9.]*')

if [ -n "$mem_usage" ]; then
  sketchybar --set "$NAME" label="${mem_usage}%" drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
