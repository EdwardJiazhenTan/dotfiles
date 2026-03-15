#!/bin/bash

# Fetch next 10 events, filter out working locations and declined
EVENT=$(gws calendar events list --params "{\"calendarId\": \"primary\", \"timeMin\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\", \"maxResults\": 10, \"singleEvents\": true, \"orderBy\": \"startTime\"}" 2>/dev/null | jq -r '
  [.items[] |
    select(.eventType != "workingLocation") |
    select((.attendees // []) | map(select(.self and .responseStatus == "declined")) | length == 0)
  ] | .[0] // empty')

if [ -z "$EVENT" ]; then
  sketchybar --set $NAME label="No events"
  exit 0
fi

SUMMARY=$(echo "$EVENT" | jq -r '.summary // "No title"')
START=$(echo "$EVENT" | jq -r '.start.dateTime // .start.date')

if [[ "$START" == *T* ]]; then
  TIME=$(date -jf "%Y-%m-%dT%H:%M:%S%z" "$(echo "$START" | sed 's/\([+-][0-9][0-9]\):\([0-9][0-9]\)$/\1\2/')" "+%H:%M" 2>/dev/null)
else
  TIME="all day"
fi

LABEL="${TIME} ${SUMMARY}"
if [ ${#LABEL} -gt 40 ]; then
  LABEL="${LABEL:0:37}..."
fi

sketchybar --set $NAME label="$LABEL"
