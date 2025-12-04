# Dotfiles Workflow Quick Reference

## Branch Strategy

```
main (shared only)
├── macos (main + macOS configs)
└── linux (main + Linux configs)
```

## Daily Workflow

### Editing Shared Configs (kitty, nvim, tmux, zsh, etc.)

```bash
# 1. Switch to main and make changes
git checkout main
# edit files...
git add .
git commit -m "Update kitty theme"

# 2. Sync to all platforms
git sync-all
```

### Editing Platform-Specific Configs

**macOS (aerospace, sketchybar, karabiner):**
```bash
git checkout macos
# edit files...
git add .
git commit -m "Update sketchybar weather widget"
git push
```

**Linux (hyprland, waybar):**
```bash
git checkout linux
# edit files...
git add .
git commit -m "Update hyprland config"
git push
```

## Git Aliases

```bash
git sync-macos   # Merge main → macos
git sync-linux   # Merge main → linux  
git sync-all     # Merge main → both platforms
```

## Branch Contents

| Config      | main | macos | linux |
|-------------|------|-------|-------|
| kitty       | ✅   | ✅    | ✅    |
| nvim        | ✅   | ✅    | ✅    |
| tmux        | ✅   | ✅    | ✅    |
| zsh         | ✅   | ✅    | ✅    |
| spicetify   | ✅   | ✅    | ✅    |
| zed         | ✅   | ✅    | ✅    |
| fastfetch   | ✅   | ✅    | ✅    |
| aerospace   | ❌   | ✅    | ❌    |
| sketchybar  | ❌   | ✅    | ❌    |
| karabiner   | ❌   | ✅    | ❌    |
| hyprland    | ❌   | ❌    | ✅    |
| waybar      | ❌   | ❌    | ✅    |

## Common Mistakes to Avoid

❌ **DON'T** commit platform-specific configs to main
❌ **DON'T** merge platform branches into each other
❌ **DON'T** merge macos/linux back into main

✅ **DO** commit shared configs to main first
✅ **DO** merge main into platform branches regularly
✅ **DO** commit platform-specific configs to their respective branches

## Recovery

If you committed to the wrong branch:

```bash
# Move last commit to another branch
git reset HEAD~1 --soft
git stash
git checkout <correct-branch>
git stash pop
git add .
git commit -m "Your commit message"
```

## Backup

Before restructuring: `backup-before-restructure-20251203`

To restore:
```bash
git checkout backup-before-restructure-20251203
```
