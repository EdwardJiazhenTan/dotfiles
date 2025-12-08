#!/usr/bin/env bash
# Input Method Plugin - Optimized for performance
# Shows current input source (Chinese/English)

# Get current input source using fastest method (skip pipefail to avoid errors)
set -eu

INPUT_SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID 2>/dev/null || echo "")

# Only try fallback if first method fails
if [ -z "$INPUT_SOURCE" ]; then
  INPUT_SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources 2>/dev/null | grep "KeyboardLayout Name" | sed -E 's/^.+ = "?([^"]*)"?;$/\1/' || echo "")
fi

# Determine label based on input source
if [[ "$INPUT_SOURCE" =~ "Chinese" ]] || [[ "$INPUT_SOURCE" =~ "Pinyin" ]] || [[ "$INPUT_SOURCE" =~ "中" ]]; then
  LABEL="CN"
elif [[ "$INPUT_SOURCE" =~ "ABC" ]] || [[ "$INPUT_SOURCE" =~ "U.S." ]] || [[ "$INPUT_SOURCE" =~ "US" ]] || [[ "$INPUT_SOURCE" =~ "English" ]]; then
  LABEL="EN"
else
  # If we can't determine, try to shorten the input source name
  if [ -n "$INPUT_SOURCE" ]; then
    LABEL=$(echo "$INPUT_SOURCE" | head -c 3)
  else
    LABEL="—"
  fi
fi

sketchybar --set "${NAME:-input_method}" label="$LABEL"
