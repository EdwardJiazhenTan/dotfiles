#!/bin/sh

# Get GPU usage percentage for macOS
# Uses ioreg to get GPU stats from PerformanceStatistics

# Get GPU stats from ioreg (works on Apple Silicon)
GPU_PERCENT=$(ioreg -r -d 1 -w 0 -c "IOAccelerator" 2>/dev/null | \
  grep -o '"Device Utilization %"=[0-9]*' | \
  awk -F'=' '{print $2}' | \
  head -1)

# If ioreg doesn't provide GPU stats, try alternative methods
if [ -z "$GPU_PERCENT" ]; then
  # Try to get from Renderer Utilization instead
  GPU_PERCENT=$(ioreg -r -d 1 -w 0 -c "IOAccelerator" 2>/dev/null | \
    grep -o '"Renderer Utilization %"=[0-9]*' | \
    awk -F'=' '{print $2}' | \
    head -1)
fi

# Fallback for Intel Macs or if above methods fail
if [ -z "$GPU_PERCENT" ]; then
  GPU_PERCENT="0"
fi

sketchybar --set "$NAME" icon="󰾲" label="${GPU_PERCENT}%"
