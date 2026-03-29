# Dotfiles

## Branch Strategy

- **main** — shared configs (kitty, nvim, tmux, zsh, starship, zed, spicetify, fastfetch)
- **macos** — main + macOS-only (aerospace, sketchybar, karabiner, ghostty, LeaderKey)
- **linux** — main + Linux-only (hyprland, waybar, hyprpanel)

Shared changes go on `main`, then merge into platform branches. Never merge platform branches back to main.

## Structure

- `.config/` — all XDG app configs
- `.zshrc` — shell config (home-level)
- `install-macos.sh` — bootstrap script (brew, stow symlinks, TPM)

## Setup

GNU Stow manages symlinks. Run `install-macos.sh` for full macOS setup.

## Rules

1. **Follow existing patterns** — match the style, structure, and conventions already in the codebase.
2. **Less code** — reuse shared functions, prefer simpler designs, avoid unnecessary abstraction.
