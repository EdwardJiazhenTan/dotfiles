#!/usr/bin/env bash
set -euo pipefail

# Fetch metrics once and cache
CACHE_FILE="/tmp/sketchybar_system_data.json"
CACHE_MAX_AGE=5  # seconds

# Check if cache is fresh
if [ -f "$CACHE_FILE" ]; then
  cache_age=$(($(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0)))
  if [ $cache_age -lt $CACHE_MAX_AGE ]; then
    cat "$CACHE_FILE"
    exit 0
  fi
fi

# Fetch fresh data
data=$(mactop --headless --count 1 2>/dev/null | grep -o '{.*}' || echo "")

if [ -z "$data" ]; then
  echo "{}"
  exit 0
fi

# Parse and cache
cpu_temp=$(echo "$data" | grep -o '"cpu_temp":[0-9.]*' | head -1 | cut -d: -f2)
cpu_usage=$(echo "$data" | grep -o '"cpu_usage":[0-9.]*' | head -1 | cut -d: -f2)
mem_used=$(echo "$data" | grep -o '"used":[0-9]*' | head -1 | cut -d: -f2)
mem_total=$(echo "$data" | grep -o '"total":[0-9]*' | head -1 | cut -d: -f2)
mem_usage=$(awk "BEGIN {printf \"%.0f\", ($mem_used/$mem_total)*100}")

# Create JSON output
cat > "$CACHE_FILE" <<EOF
{
  "cpu_temp": "${cpu_temp:-0}",
  "cpu_usage": "${cpu_usage:-0}",
  "mem_usage": "${mem_usage:-0}"
}
EOF

cat "$CACHE_FILE"
