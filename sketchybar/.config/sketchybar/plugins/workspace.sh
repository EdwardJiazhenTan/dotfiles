#!/usr/bin/env bash
set -euo pipefail

WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null || echo "?")
LETTER="${WORKSPACE:0:1}"

case "$LETTER" in
A) ICON="󰚩" ;; # AI
W) ICON="󰊯" ;; # Web
T) ICON="󰆍" ;; # Terminal
P) ICON="" ;; # Productivity
S) ICON="" ;; # Social Media
G) ICON="󰊴" ;; # Gaming
X) ICON="󰿨" ;; # Extra
C) ICON="" ;; # Coding
V) ICON="󰕧" ;; # Video
M) ICON="" ;; # Music
D) ICON="" ;; # Docker
*) ICON="$LETTER" ;;
esac

sketchybar --set "$NAME" icon="$ICON" label="$LETTER" 2>/dev/null || true
