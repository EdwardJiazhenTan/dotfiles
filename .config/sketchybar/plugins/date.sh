#!/usr/bin/env bash
set -euo pipefail

sketchybar --set "$NAME" label="$(date '+%a %d')" 2>/dev/null || true
