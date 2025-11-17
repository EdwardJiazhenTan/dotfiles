#!/bin/sh

# Get CPU usage percentage (average across all cores)
CPU_INFO=$(top -l 2 -n 0 -F -R -o cpu | grep "CPU usage")
CPU_USER=$(echo "$CPU_INFO" | tail -1 | awk '{print $3}' | sed 's/%//' | cut -d. -f1)
CPU_SYS=$(echo "$CPU_INFO" | tail -1 | awk '{print $5}' | sed 's/%//' | cut -d. -f1)

# Calculate total CPU usage using shell arithmetic
CPU_PERCENT=$((CPU_USER + CPU_SYS))

sketchybar --set "$NAME" icon="" label="${CPU_PERCENT}%"
