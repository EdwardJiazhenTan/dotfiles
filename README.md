# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Configurations

- **aerospace** - Tiling window manager for macOS
- **hyprland** - Wayland compositor/tiling window manager for Arch Linux
- **hyprpanel** - Panel/bar for Hyprland
- **karabiner** - Keyboard customization tool for macOS
- **kitty** - GPU-accelerated terminal emulator
- **nvim** - Neovim text editor configuration
- **tmux** - Terminal multiplexer
- **zed** - Zed code editor configuration

## Installation

1. Install GNU Stow:
   ```bash
   # macOS
   brew install stow

   # Arch Linux
   sudo pacman -S stow
   ```

2. Clone this repository:
   ```bash
   git clone <repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

3. Use stow to symlink configurations:
   ```bash
   # Install specific config
   stow nvim
   stow kitty

   # Install all configs
   stow */

   # Remove a config
   stow -D nvim
   ```

## Notes

The `.zshrc` file is in the root directory and needs to be symlinked manually or moved to a zsh stow package.
