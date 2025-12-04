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

> **Note**: You are currently on the `macos` branch with all macOS-specific configurations.

### Linux-specific (linux branch)
- **hyprland** - Wayland compositor/tiling window manager
- **waybar** - Status bar for Wayland
- **hyprpanel** - Panel/bar for Hyprland

> **Note**: You are currently on the `main` branch with shared configs only. 
> Checkout `macos` or `linux` branch for platform-specific configurations.

## Developer Workflow

### Making Changes to Shared Configs

When updating configs that should be shared across platforms (kitty, nvim, tmux, zsh, etc.):

```bash
# 1. Make changes on main branch
git checkout main
# ... edit kitty/nvim/tmux configs ...
git add .
git commit -m "Update shared config"

# 2. Sync to macOS
git checkout macos
git merge main
git push

# 3. Sync to Linux
git checkout linux
git merge main
git push
```

### Making Platform-Specific Changes

For macOS-specific changes (aerospace, sketchybar, karabiner):

```bash
git checkout macos
# ... edit platform-specific configs ...
git add .
git commit -m "Update macOS config"
git push
```

For Linux-specific changes (hyprland, waybar):

```bash
git checkout linux
# ... edit platform-specific configs ...
git add .
git commit -m "Update Linux config"
git push
```

### Quick Sync Aliases

Add these to your `~/.gitconfig` for easier syncing:

```gitconfig
[alias]
    sync-macos = !git checkout macos && git merge main && git checkout -
    sync-linux = !git checkout linux && git merge main && git checkout -
    sync-all = !git checkout macos && git merge main && git checkout linux && git merge main && git checkout -
```

Usage:
```bash
# After committing to main
git sync-all  # Syncs main to both platform branches
```

## Installation

### Automated Installation (macOS)

```bash
# Clone and checkout macOS branch
git clone https://github.com/EdwardJiazhenTan/dotfiles ~/dotfiles
cd ~/dotfiles
git checkout macos

# Run automated installation script
./install-macos.sh
```

This script will:
- Install Homebrew and all required applications
- Install GNU Stow and manage symlinks
- Backup existing configurations
- Install Tmux Plugin Manager and Neovim plugins

### Manual Installation (macOS)

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
