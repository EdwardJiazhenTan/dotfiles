# Dotfiles

## Branch Strategy

- **main** — active shared configuration for macOS and Arch Linux
- **macos** — historical macOS snapshot; do not add new work
- **hyprland** — historical Hyprland snapshot retained for reference; active desktop configuration belongs in `Tekindar666/hyprland-dotfiles`

## Structure

- `.config/` — shared terminal and CLI application configuration
- `.config/zsh/entrypoints/` — installer-selected Zsh entrypoints
- `.config/zsh/platform/` — platform-specific shell paths
- `install.sh` — Homebrew/pacman bootstrap, symlinks, and TPM

## Rules

1. Follow existing patterns and keep platform differences isolated.
2. Reuse shared functions and prefer minimal configuration.
3. Keep private and machine-local application state outside this repository.
4. Keep Hyprland, Hyprpaper, Dunst, Rofi, Waybar, and SDDM configuration in `Tekindar666/hyprland-dotfiles`.
