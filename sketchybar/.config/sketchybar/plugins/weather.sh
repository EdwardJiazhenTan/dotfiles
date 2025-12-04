#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Weather Widget for SketchyBar
# =============================================================================
# Fetches weather data from wttr.in and displays temperature + condition
# 
# Features:
# - 10-minute cache to avoid rate limiting
# - Automatic state name abbreviation (e.g., "New York" -> "NY")
# - Graceful fallback to cached data if fetch fails
#
# Customize location below (city name, coordinates, or empty for auto-detect)
# Format examples: "New+York", "Rochester,+NY", "40.7128,-74.0060"
# =============================================================================

LOCATION=""  # Empty for auto-detection based on IP

# Cache file to avoid too frequent requests
CACHE_FILE="/tmp/sketchybar_weather_cache"
CACHE_TIME=600 # 10 minutes in seconds

# Initialize WEATHER variable
WEATHER=""

# Get current time
CURRENT_TIME=$(date +%s)

# Check if cache exists and is still fresh
if [ -f "$CACHE_FILE" ]; then
  CACHE_TIMESTAMP=$(stat -f %m "$CACHE_FILE" 2>/dev/null || stat -c %Y "$CACHE_FILE" 2>/dev/null)
  TIME_DIFF=$((CURRENT_TIME - CACHE_TIMESTAMP))

  if [ $TIME_DIFF -lt $CACHE_TIME ]; then
    # Use cached data
    WEATHER=$(cat "$CACHE_FILE")
  fi
fi

# Fetch new weather data if cache is stale or doesn't exist
if [ -z "$WEATHER" ]; then
  # If location is empty, try to auto-detect using ipinfo.io
  if [ -z "$LOCATION" ]; then
    DETECTED_CITY=$(curl -s --connect-timeout 3 "https://ipinfo.io/city" 2>/dev/null)
    if [ -n "$DETECTED_CITY" ]; then
      LOCATION="$DETECTED_CITY"
    fi
  fi
  
  # Fetch weather from wttr.in
  # %t = temperature, %C = condition (no emoji), m for metric (Celsius)
  RAW_WEATHER=$(curl -s --connect-timeout 5 "wttr.in/${LOCATION}?format=%t+%C&m" 2>/dev/null)

  # If fetch successful, format with location
  if [ -n "$RAW_WEATHER" ] && [ "$RAW_WEATHER" != "" ] && [[ "$RAW_WEATHER" != *"Unknown location"* ]]; then
    if [ -n "$LOCATION" ]; then
      WEATHER="$LOCATION · $RAW_WEATHER"
    else
      WEATHER="$RAW_WEATHER"
    fi
    echo "$WEATHER" >"$CACHE_FILE"
  else
    # If fetch failed, try to use old cache or show error
    if [ -f "$CACHE_FILE" ]; then
      WEATHER=$(cat "$CACHE_FILE")
    else
      WEATHER="N/A"
    fi
  fi
fi

# Clean up the weather string
# Replace + with · separator, remove country, abbreviate states
WEATHER=$(echo "$WEATHER" | sed -e 's/+/ · /g' \
  -e 's/, United States//g' \
  -e 's/New Jersey/NJ/g' \
  -e 's/New York/NY/g' \
  -e 's/California/CA/g' \
  -e 's/Texas/TX/g' \
  -e 's/Florida/FL/g' \
  -e 's/Pennsylvania/PA/g' \
  -e 's/Illinois/IL/g' \
  -e 's/Ohio/OH/g' \
  -e 's/Georgia/GA/g' \
  -e 's/North Carolina/NC/g' \
  -e 's/South Carolina/SC/g' \
  -e 's/Michigan/MI/g' \
  -e 's/Virginia/VA/g' \
  -e 's/West Virginia/WV/g' \
  -e 's/Washington/WA/g' \
  -e 's/Arizona/AZ/g' \
  -e 's/Massachusetts/MA/g' \
  -e 's/Tennessee/TN/g' \
  -e 's/Indiana/IN/g' \
  -e 's/Missouri/MO/g' \
  -e 's/Maryland/MD/g' \
  -e 's/Wisconsin/WI/g' \
  -e 's/Colorado/CO/g' \
  -e 's/Minnesota/MN/g' \
  -e 's/Alabama/AL/g' \
  -e 's/Louisiana/LA/g' \
  -e 's/Kentucky/KY/g' \
  -e 's/Oregon/OR/g' \
  -e 's/Oklahoma/OK/g' \
  -e 's/Connecticut/CT/g' \
  -e 's/Utah/UT/g' \
  -e 's/Iowa/IA/g' \
  -e 's/Nevada/NV/g' \
  -e 's/Arkansas/AR/g' \
  -e 's/Mississippi/MS/g' \
  -e 's/Kansas/KS/g' \
  -e 's/New Mexico/NM/g' \
  -e 's/Nebraska/NE/g' \
  -e 's/Idaho/ID/g' \
  -e 's/Hawaii/HI/g' \
  -e 's/New Hampshire/NH/g' \
  -e 's/Maine/ME/g' \
  -e 's/Montana/MT/g' \
  -e 's/Rhode Island/RI/g' \
  -e 's/Delaware/DE/g' \
  -e 's/South Dakota/SD/g' \
  -e 's/North Dakota/ND/g' \
  -e 's/Alaska/AK/g' \
  -e 's/Vermont/VT/g' \
  -e 's/Wyoming/WY/g' \
  -e 's/, / · /g' | xargs)

# Update sketchybar
sketchybar --set "${NAME:-weather}" label="$WEATHER"
