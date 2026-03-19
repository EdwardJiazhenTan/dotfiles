#!/bin/bash

COUNT=$(gws gmail users messages list --params '{"userId": "me", "q": "is:unread in:inbox", "maxResults": 500}' 2>/dev/null | jq '.messages // [] | length')

if [ -z "$COUNT" ] || ! [[ "$COUNT" =~ ^[0-9]+$ ]]; then
  COUNT=0
fi

sketchybar --set $NAME label="$COUNT" icon.drawing=on
