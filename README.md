# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Branch Structure

This repository uses a **branch-based strategy** to manage platform-specific and shared configurations:

- **main** - Shared configurations that work across all platforms
- **macos** - macOS-specific configs (merges from main + macOS additions)
- **linux** - Linux-specific configs (merges from main + Linux additions)

### Workflow

1. **Shared config changes** → commit to `main` branch
2. **Platform-specific changes** → commit to `macos` or `linux` branch
3. **Syncing shared configs** → merge `main` into platform branches regularly

```bash
# Work on shared configs (kitty, nvim, tmux, etc.)
git checkout main
# ... make changes ...
git add . && git commit -m "Update nvim config"

# Sync to macOS
git checkout macos
git merge main

# Sync to Linux
git checkout linux
git merge main
```

## Configurations

### Shared (main branch)
- **kitty** - GPU-accelerated terminal emulator
- **nvim** - Neovim text editor configuration
- **tmux** - Terminal multiplexer
- **zsh** - Zsh shell configuration
- **spicetify** - Spotify customization
- **zed** - Zed code editor configuration
- **fastfetch** - System information tool

### macOS-specific (macos branch)
- **aerospace** - Tiling window manager for macOS
- **sketchybar** - Status bar for macOS
- **karabiner** - Keyboard customization tool for macOS

### Linux-specific (linux branch)
- **hyprland** - Wayland compositor/tiling window manager
- **waybar** - Status bar for Wayland
- **hyprpanel** - Panel/bar for Hyprland

## Installation

### macOS

```bash
# Clone and checkout macOS branch
git clone https://github.com/EdwardJiazhenTan/dotfiles ~/dotfiles
cd ~/dotfiles
git checkout macos

# Install Homebrew and GNU Stow
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install stow

# Stow all configurations
stow */
```

See the `macos` branch for the automated installation script.

### Linux

```bash
# Clone and checkout linux branch
git clone https://github.com/EdwardJiazhenTan/dotfiles ~/dotfiles
cd ~/dotfiles
git checkout linux

# Install GNU Stow
sudo pacman -S stow  # Arch Linux
# or: sudo apt install stow  # Debian/Ubuntu

# Stow all configurations
stow */
```

### Manual Stow Usage

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

- The installation script automatically handles all configurations including `.zshrc`
- All shell scripts use `#!/usr/bin/env bash` for better portability
- Sensitive environment variables should be stored in `~/.env` (not tracked in git)
