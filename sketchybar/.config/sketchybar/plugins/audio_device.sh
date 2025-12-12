#!/usr/bin/env bash

set -euo pipefail

# get current audio output device using Switchaudiosource
DEVICE=$(SwitchAudioSource -c)

# Map device names to custom short names with icons
case "$DEVICE" in
"MacBook Air Speakers")
  LABEL="MBA"
  ;;
*"张可儿Olivia的AirPods"*)
  LABEL="AirPods"
  ;;
*"HK SoundStick 4"*)
  LABEL="HK"
  ;;
*)
  # fallback
  LABEL="$DEVICE"
  ;;
esac

# Update sketchybar item
sketchybar --set "$NAME" label="$LABEL"
