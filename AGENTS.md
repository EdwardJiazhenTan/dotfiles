# Dotfiles

## Branch Strategy

- **macos** — macOS configs and shared configs in the flattened repo layout
- **hyprland** — Hyprland/Linux configs and shared configs in the older Stow package layout

Sync shared settings intentionally between branches. Do not merge platform branches into each other.

## Structure

- `.config/` — all XDG app configs
- `.zshrc` — shell config (home-level)
- `install-macos.sh` — bootstrap script (brew, symlinks, TPM)

## Setup

## Rules

1. **Follow existing patterns** — match the style, structure, and conventions already in the codebase.
2. **Less code** — reuse shared functions, prefer simpler designs, avoid unnecessary abstraction.
