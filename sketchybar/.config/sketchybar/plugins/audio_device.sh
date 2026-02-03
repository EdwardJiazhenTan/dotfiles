#!/usr/bin/env bash

set -euo pipefail

# get current audio output device using Switchaudiosource with error handling
DEVICE=$(SwitchAudioSource -c 2>/dev/null || echo "Unknown")

# Map device names to custom short names with icons
case "$DEVICE" in
*"MacBook Pro Speakers"*)
LABEL="MBP"
;;
*"张可儿Olivia的AirPods"*)
  LABEL="AirPods"
  ;;
*"HK SoundStick 4"*)
  LABEL="HK"
  ;;
"Unknown")
  LABEL="?"
  ;;
*)
  # fallback
  LABEL="$DEVICE"
  ;;
esac

# Update sketchybar item
sketchybar --set "$NAME" label="$LABEL" 2>/dev/null || true
