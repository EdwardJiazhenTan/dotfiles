# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Branch Structure

This repository uses branches to separate platform-specific configurations:

- **main** - Shared configurations (kitty, nvim, tmux, zed, .zshrc)
- **hyprland** - Linux/Hyprland-specific configs (hyprland, hyprpanel)
- **macos** - macOS-specific configs (aerospace, karabiner)

## Configurations

### Shared (main branch)
- **kitty** - GPU-accelerated terminal emulator
- **nvim** - Neovim text editor configuration
- **tmux** - Terminal multiplexer
- **zed** - Zed code editor configuration
- **.zshrc** - Zsh shell configuration

### Hyprland (hyprland branch)
- **hyprland** - Wayland compositor/tiling window manager for Arch Linux
- **hyprpanel** - Panel/bar for Hyprland

### macOS (macos branch)
- **aerospace** - Tiling window manager for macOS
- **karabiner** - Keyboard customization tool for macOS

## Installation

1. Install GNU Stow:
   ```bash
   # macOS
   brew install stow

   # Arch Linux
   sudo pacman -S stow
   ```

2. Clone this repository and checkout the appropriate branch:
   ```bash
   git clone https://github.com/EdwardJiazhenTan/dotfiles ~/dotfiles
   cd ~/dotfiles

   # For Hyprland/Linux
   git checkout hyprland

   # For macOS
   git checkout macos
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
