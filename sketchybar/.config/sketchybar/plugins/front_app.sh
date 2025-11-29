#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then
  # Map common applications to icons
  case "$INFO" in
    "kitty"|"iTerm2"|"Terminal"|"Alacritty") ICON="󰆍" ;;
    "Chrome"|"Google Chrome") ICON="󰊯" ;;
    "Safari") ICON="󰀹" ;;
    "Firefox") ICON="󰈹" ;;
    "zen"|"Zen Browser"|"Zen") ICON="󰈹" ;;
    "Arc") ICON="" ;;
    "Code"|"Visual Studio Code"|"VSCode") ICON="󰨞" ;;
    "Neovide"|"MacVim"|"VimR") ICON="" ;;
    "Xcode") ICON="" ;;
    "Slack") ICON="󰒱" ;;
    "Discord") ICON="󰙯" ;;
    "Telegram"|"Messages") ICON="󰻞" ;;
    "Spotify") ICON="󰓇" ;;
    "Music") ICON="󰎆" ;;
    "VLC"|"QuickTime Player"|"IINA") ICON="󰕧" ;;
    "Finder") ICON="" ;;
    "Notes"|"Notion") ICON="󰈙" ;;
    "Mail"|"Outlook") ICON="󰇮" ;;
    "Calendar") ICON="" ;;
    "Obsidian") ICON="󱓧" ;;
    "ChatGPT"|"Claude") ICON="󰚩" ;;
    "Steam") ICON="󰊴" ;;
    "Docker"|"Docker Desktop") ICON="󰡨" ;;
    "Postman") ICON="󰛮" ;;
    *) ICON="󰀘" ;;  # Default app icon
  esac

  sketchybar --set "$NAME" icon="$ICON" label="$INFO"
fi
