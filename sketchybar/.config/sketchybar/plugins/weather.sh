#!/bin/sh

# Weather widget for sketchybar
# Uses wttr.in for weather data

# You can customize your location here (city name, coordinates, or leave empty for auto-detect)
LOCATION="Rochester, NY"

# Cache file to avoid too frequent requests
CACHE_FILE="/tmp/sketchybar_weather_cache"
CACHE_TIME=600 # 10 minutes in seconds

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
  # Fetch weather from wttr.in (format: location, temperature in Celsius, condition)
  # %l = location, %t = temperature, %C = condition (no emoji)
  # m for metric (Celsius), no + sign by default with %t
  WEATHER=$(curl -s "wttr.in/${LOCATION}?format=%l+%t+%C&m" 2>/dev/null)

  # If fetch successful, update cache
  if [ -n "$WEATHER" ] && [ "$WEATHER" != "" ]; then
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

# Clean up the weather string (remove + sign, country, format state, replace separators with dots)
# Remove ", United States" and convert state names to abbreviations
WEATHER=$(echo "$WEATHER" | sed 's/+/ · /g' | sed 's/, United States//g' | sed 's/New Jersey/NJ/g' | sed 's/New York/NY/g' | sed 's/California/CA/g' | sed 's/Texas/TX/g' | sed 's/Florida/FL/g' | sed 's/Pennsylvania/PA/g' | sed 's/Illinois/IL/g' | sed 's/Ohio/OH/g' | sed 's/Georgia/GA/g' | sed 's/North Carolina/NC/g' | sed 's/Michigan/MI/g' | sed 's/Virginia/VA/g' | sed 's/Washington/WA/g' | sed 's/Arizona/AZ/g' | sed 's/Massachusetts/MA/g' | sed 's/Tennessee/TN/g' | sed 's/Indiana/IN/g' | sed 's/Missouri/MO/g' | sed 's/Maryland/MD/g' | sed 's/Wisconsin/WI/g' | sed 's/Colorado/CO/g' | sed 's/Minnesota/MN/g' | sed 's/South Carolina/SC/g' | sed 's/Alabama/AL/g' | sed 's/Louisiana/LA/g' | sed 's/Kentucky/KY/g' | sed 's/Oregon/OR/g' | sed 's/Oklahoma/OK/g' | sed 's/Connecticut/CT/g' | sed 's/Utah/UT/g' | sed 's/Iowa/IA/g' | sed 's/Nevada/NV/g' | sed 's/Arkansas/AR/g' | sed 's/Mississippi/MS/g' | sed 's/Kansas/KS/g' | sed 's/New Mexico/NM/g' | sed 's/Nebraska/NE/g' | sed 's/West Virginia/WV/g' | sed 's/Idaho/ID/g' | sed 's/Hawaii/HI/g' | sed 's/New Hampshire/NH/g' | sed 's/Maine/ME/g' | sed 's/Montana/MT/g' | sed 's/Rhode Island/RI/g' | sed 's/Delaware/DE/g' | sed 's/South Dakota/SD/g' | sed 's/North Dakota/ND/g' | sed 's/Alaska/AK/g' | sed 's/Vermont/VT/g' | sed 's/Wyoming/WY/g' | sed 's/, / · /g' | xargs)

# Update sketchybar
sketchybar --set "$NAME" label="$WEATHER"
