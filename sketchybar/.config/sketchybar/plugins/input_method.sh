#!/bin/bash

# Input Method Plugin
# Shows current input source (Chinese/English)

# Get current input source
INPUT_SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | sed -E 's/^.+ = "?([^"]*)"?;$/\1/')

# If the above doesn't work, try alternative method
if [ -z "$INPUT_SOURCE" ]; then
  INPUT_SOURCE=$(osascript -e 'tell application "System Events" to tell process "SystemUIServer" to return name of first menu bar item of menu bar 1 whose description is "text input"' 2>/dev/null)
fi

# Another fallback using defaults
if [ -z "$INPUT_SOURCE" ]; then
  INPUT_SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID 2>/dev/null)
fi

# Determine label based on input source
if [[ "$INPUT_SOURCE" =~ "Chinese" ]] || [[ "$INPUT_SOURCE" =~ "Pinyin" ]] || [[ "$INPUT_SOURCE" =~ "中" ]]; then
  LABEL="CN"
elif [[ "$INPUT_SOURCE" =~ "ABC" ]] || [[ "$INPUT_SOURCE" =~ "U.S." ]] || [[ "$INPUT_SOURCE" =~ "English" ]]; then
  LABEL="EN"
else
  # If we can't determine, try to shorten the input source name
  if [ -n "$INPUT_SOURCE" ]; then
    LABEL=$(echo "$INPUT_SOURCE" | head -c 3)
  else
    LABEL="—"
  fi
fi

sketchybar --set "$NAME" label="$LABEL"
