# Dotfiles

Personal configuration files for macOS and Hyprland/Linux.

## Branch Structure

This repository uses platform branches:

- **macos** - macOS configs plus shared configs in the flattened `.config/*` layout
- **hyprland** - Hyprland/Linux configs plus shared configs in the older Stow package layout

Shared settings are synced intentionally between branches. Platform branches are not merged into each other.

## Configurations

### Shared
- **kitty** - GPU-accelerated terminal emulator
- **nvim** - Neovim text editor configuration
- **tmux** - Terminal multiplexer
- **zsh** - Zsh shell configuration
- **starship** - Shell prompt configuration
- **fastfetch** - System information tool

### macOS-specific (`macos` branch)
- **ghostty** - GPU-accelerated terminal emulator for macOS

### Linux-specific (`hyprland` branch)
- **hyprland** - Wayland compositor/tiling window manager
- **waybar** - Status bar for Wayland
- **hyprpanel** - Panel/bar for Hyprland

## Developer Workflow

For macOS-specific changes:

```bash
git checkout macos
# ... edit platform-specific configs ...
git add .
git commit -m "Update macOS config"
git push
```

For Hyprland/Linux-specific changes:

```bash
git checkout hyprland
# ... edit platform-specific configs ...
git add .
git commit -m "Update Linux config"
git push
```

For shared settings, update one branch and copy the same setting to the other branch deliberately.

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
- Symlink tracked dotfiles into `$HOME`
- Backup existing configurations
- Install Tmux Plugin Manager

### Manual Installation (macOS)

```bash
# Clone and checkout macOS branch
git clone https://github.com/EdwardJiazhenTan/dotfiles ~/dotfiles
cd ~/dotfiles
git checkout macos

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Link configs
ln -sfn "$PWD/.config"/* ~/.config/
ln -sf "$PWD/.zshrc" ~/.zshrc
ln -sf "$PWD/.gitconfig" ~/.gitconfig
```

### Linux

```bash
# Clone and checkout hyprland branch
git clone https://github.com/EdwardJiazhenTan/dotfiles ~/dotfiles
cd ~/dotfiles
git checkout hyprland

# Install GNU Stow
sudo pacman -S stow  # Arch Linux
# or: sudo apt install stow  # Debian/Ubuntu

# Stow all configurations
stow */
```

### Manual Stow Usage (`hyprland` branch)

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
