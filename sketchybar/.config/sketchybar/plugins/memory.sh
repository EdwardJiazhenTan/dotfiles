#!/bin/sh

# Get memory usage percentage
MEMORY_PERCENT=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100-$5}' | sed 's/%//')

# If that doesn't work, use vm_stat
if [ -z "$MEMORY_PERCENT" ]; then
  PAGE_SIZE=$(pagesize)
  VM_STAT=$(vm_stat)

  PAGES_FREE=$(echo "$VM_STAT" | awk '/Pages free/ {print $3}' | sed 's/\.//')
  PAGES_ACTIVE=$(echo "$VM_STAT" | awk '/Pages active/ {print $3}' | sed 's/\.//')
  PAGES_INACTIVE=$(echo "$VM_STAT" | awk '/Pages inactive/ {print $3}' | sed 's/\.//')
  PAGES_WIRED=$(echo "$VM_STAT" | awk '/Pages wired down/ {print $4}' | sed 's/\.//')

  TOTAL_PAGES=$((PAGES_FREE + PAGES_ACTIVE + PAGES_INACTIVE + PAGES_WIRED))
  USED_PAGES=$((PAGES_ACTIVE + PAGES_WIRED))

  MEMORY_PERCENT=$((USED_PAGES * 100 / TOTAL_PAGES))
fi

sketchybar --set "$NAME" icon="⚡" label="${MEMORY_PERCENT}%"
