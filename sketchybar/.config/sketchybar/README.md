# Sketchybar Config

## Setup

1. Install sketchybar:
   ```bash
   brew install sketchybar
   ```

2. Symlink config:
   ```bash
   ln -s ~/dotfiles/sketchybar/.config/sketchybar ~/.config/sketchybar
   ```

3. Start sketchybar:
   ```bash
   brew services start sketchybar
   ```

## Slack Widget

The slack plugin reads unread message count from the Dock badge.

### Requirements

Add sketchybar to Accessibility permissions:

1. System Settings → Privacy & Security → Accessibility
2. Click **+**, press **Cmd+Shift+G**
3. Enter `/opt/homebrew/bin/sketchybar`
4. Enable the checkbox

Without this, the AppleScript cannot read Dock badges and will always show 0.
