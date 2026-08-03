# Dotfiles

## Branch Strategy

- **main** — active shared configuration for macOS and Arch Linux
- **macos** — historical macOS snapshot; do not add new work
- **hyprland** — historical Hyprland snapshot pending extraction; do not merge into `main`

## Structure

- `.config/` — shared XDG application configuration
- `.config/zsh/entrypoints/` — installer-selected Zsh entrypoints
- `.config/zsh/platform/` — platform-specific shell paths
- `install.sh` — Homebrew/pacman bootstrap, symlinks, and TPM

## Rules

1. Follow existing patterns and keep platform differences isolated.
2. Reuse shared functions and prefer minimal configuration.
3. Keep private and machine-local application state outside this repository.
