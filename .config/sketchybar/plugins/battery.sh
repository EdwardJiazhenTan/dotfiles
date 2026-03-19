#!/usr/bin/env bash
set -euo pipefail

PERCENTAGE="$(pmset -g batt 2>/dev/null | grep -Eo "[0-9]+%" | cut -d% -f1 || echo "")"
CHARGING="$(pmset -g batt 2>/dev/null | grep 'AC Power' || echo "")"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON="󰁹"
  ;;
  [6-8][0-9]) ICON="󰂀"
  ;;
  [3-5][0-9]) ICON="󰁾"
  ;;
  [1-2][0-9]) ICON="󰁻"
  ;;
  *) ICON="󰁺"
esac

if [[ "$CHARGING" != "" ]]; then
  ICON="󰂄"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" 2>/dev/null || true
