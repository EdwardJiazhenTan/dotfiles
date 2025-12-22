#!/usr/bin/env bash
set -euo pipefail

# Thresholds
CPU_TEMP_MAX=80
GPU_TEMP_MAX=80
CPU_USAGE_MAX=80
GPU_USAGE_MAX=80
MEM_USAGE_MAX=70

# Get metrics
data=$(mactop --headless --count 1 2>/dev/null | grep -o '{.*}' || echo "")

if [ -z "$data" ]; then
  sketchybar --set "$NAME" drawing=off 2>/dev/null || true
  exit 0
fi

cpu_temp=$(echo "$data" | grep -o '"cpu_temp":[0-9.]*' | head -1 | cut -d: -f2)
gpu_temp=$(echo "$data" | grep -o '"gpu_temp":[0-9.]*' | head -1 | cut -d: -f2)
cpu_usage=$(echo "$data" | grep -o '"cpu_usage":[0-9.]*' | head -1 | cut -d: -f2)
gpu_usage=$(echo "$data" | grep -o '"gpu_usage":[0-9.]*' | head -1 | cut -d: -f2)
mem_used=$(echo "$data" | grep -o '"used":[0-9]*' | head -1 | cut -d: -f2)
mem_total=$(echo "$data" | grep -o '"total":[0-9]*' | head -1 | cut -d: -f2)
mem_usage=$(awk "BEGIN {printf \"%.0f\", ($mem_used/$mem_total)*100}")

# Build display string with all stats
display=()
[ -n "$cpu_usage" ] && display+=("CPU:${cpu_usage%.*}%")
[ -n "$mem_usage" ] && display+=("MEM:${mem_usage}%")
[ -n "$cpu_temp" ] && display+=("$(printf "%.0f" "$cpu_temp")°C")

# Always show the stats
if [ ${#display[@]} -gt 0 ]; then
  DISPLAY_STR=$(printf " %s | " "${display[@]}")
  DISPLAY_STR="${DISPLAY_STR% | }"  # Remove trailing separator
  sketchybar --set "$NAME" label="$DISPLAY_STR" drawing=on 2>/dev/null || true
else
  sketchybar --set "$NAME" drawing=off 2>/dev/null || true
fi
