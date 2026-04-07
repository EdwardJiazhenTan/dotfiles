#!/usr/bin/env bash

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    log_error "This script is for macOS only!"
    exit 1
fi

log_info "Starting macOS dotfiles installation..."

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    log_success "Homebrew installed"
else
    log_success "Homebrew already installed"
fi

# Install required applications
log_info "Installing required applications..."

# Terminal emulator
if ! command -v kitty &> /dev/null; then
    log_info "Installing Kitty terminal..."
    brew install --cask kitty
    log_success "Kitty installed"
else
    log_success "Kitty already installed"
fi

# Neovim
if ! command -v nvim &> /dev/null; then
    log_info "Installing Neovim..."
    brew install neovim
    log_success "Neovim installed"
else
    log_success "Neovim already installed"
fi

# Tmux
if ! command -v tmux &> /dev/null; then
    log_info "Installing tmux..."
    brew install tmux
    log_success "Tmux installed"
else
    log_success "Tmux already installed"
fi

# Aerospace (window manager)
if ! command -v aerospace &> /dev/null; then
    log_info "Installing Aerospace..."
    brew install --cask nikitabobko/tap/aerospace
    log_success "Aerospace installed"
else
    log_success "Aerospace already installed"
fi

# Karabiner-Elements (keyboard customization)
if [ ! -d "/Applications/Karabiner-Elements.app" ]; then
    log_info "Installing Karabiner-Elements..."
    brew install --cask karabiner-elements
    log_success "Karabiner-Elements installed"
else
    log_success "Karabiner-Elements already installed"
fi

# SketchyBar (status bar)
if ! command -v sketchybar &> /dev/null; then
    log_info "Installing SketchyBar..."
    brew tap FelixKratz/formulae
    brew install sketchybar
    log_success "SketchyBar installed"
else
    log_success "SketchyBar already installed"
fi

# Zed editor (optional)
if [ ! -d "/Applications/Zed.app" ]; then
    log_info "Installing Zed editor..."
    brew install --cask zed
    log_success "Zed installed"
else
    log_success "Zed already installed"
fi

# Spicetify (Spotify customization)
if ! command -v spicetify &> /dev/null; then
    log_info "Installing Spicetify..."
    brew install spicetify-cli
    log_success "Spicetify installed"
else
    log_success "Spicetify already installed"
fi

# Fastfetch (system information tool)
if ! command -v fastfetch &> /dev/null; then
    log_info "Installing fastfetch..."
    brew install fastfetch
    log_success "Fastfetch installed"
else
    log_success "Fastfetch already installed"
fi

# Starship prompt
if ! command -v starship &> /dev/null; then
    log_info "Installing starship prompt..."
    brew install starship
    log_success "Starship installed"
else
    log_success "Starship already installed"
fi

# Zoxide (smarter cd command)
if ! command -v zoxide &> /dev/null; then
    log_info "Installing zoxide..."
    brew install zoxide
    log_success "Zoxide installed"
else
    log_success "Zoxide already installed"
fi

# FZF (fuzzy finder)
if ! command -v fzf &> /dev/null; then
    log_info "Installing fzf..."
    brew install fzf
    log_success "FZF installed"
else
    log_success "FZF already installed"
fi

# fd (better find)
if ! command -v fd &> /dev/null; then
    log_info "Installing fd..."
    brew install fd
    log_success "fd installed"
else
    log_success "fd already installed"
fi

# bat (better cat)
if ! command -v bat &> /dev/null; then
    log_info "Installing bat..."
    brew install bat
    log_success "bat installed"
else
    log_success "bat already installed"
fi

# tree (directory visualization)
if ! command -v tree &> /dev/null; then
    log_info "Installing tree..."
    brew install tree
    log_success "tree installed"
else
    log_success "tree already installed"
fi

# zsh-autosuggestions
if [ ! -d "$(brew --prefix)/share/zsh-autosuggestions" ]; then
    log_info "Installing zsh-autosuggestions..."
    brew install zsh-autosuggestions
    log_success "zsh-autosuggestions installed"
else
    log_success "zsh-autosuggestions already installed"
fi

# zsh-syntax-highlighting
if [ ! -d "$(brew --prefix)/share/zsh-syntax-highlighting" ]; then
    log_info "Installing zsh-syntax-highlighting..."
    brew install zsh-syntax-highlighting
    log_success "zsh-syntax-highlighting installed"
else
    log_success "zsh-syntax-highlighting already installed"
fi

# Install SF Mono Nerd Font for better terminal experience
log_info "Installing Nerd Fonts..."
brew install --cask font-sf-mono-nerd-font-ligaturized || log_warning "Font already installed or unavailable"
brew install --cask font-jetbrains-mono-nerd-font || log_warning "Font already installed or unavailable"

# GNU Stow
if ! command -v stow &> /dev/null; then
    log_info "Installing GNU Stow..."
    brew install stow
    log_success "Stow installed"
else
    log_success "Stow already installed"
fi

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

log_info "Current directory: $SCRIPT_DIR"

# Backup existing configurations
backup_if_exists() {
    local path="$1"
    if [ -e "$path" ] && [ ! -L "$path" ]; then
        local backup_path="${path}.backup.$(date +%Y%m%d_%H%M%S)"
        log_warning "Backing up existing $path to $backup_path"
        mv "$path" "$backup_path"
    fi
}

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.claude"

# Stow named packages (subdirs with a .config/ inside)
# Collect which .config/ entries are owned by stow packages so we skip them below
declare -a STOW_OWNED_CONFIGS=()
for pkg_dir in "$SCRIPT_DIR"/*/; do
    [ -d "$pkg_dir/.config" ] || continue
    pkg="$(basename "$pkg_dir")"
    log_info "Stowing package: $pkg..."
    stow -d "$SCRIPT_DIR" -t "$HOME" --restow "$pkg"
    log_success "Stowed $pkg"
    for cfg in "$pkg_dir/.config"/*/; do
        STOW_OWNED_CONFIGS+=("$(basename "$cfg")")
    done
done

# Symlink root-level .config/ entries (skip any owned by a stow package)
log_info "Symlinking root-level configs..."
for item in "$SCRIPT_DIR/.config"/*; do
    name="$(basename "$item")"
    skip=false
    for owned in "${STOW_OWNED_CONFIGS[@]}"; do
        [ "$name" = "$owned" ] && { skip=true; break; }
    done
    if $skip; then
        log_info "Skipping .config/$name (managed by stow package)"
        continue
    fi
    backup_if_exists "$HOME/.config/$name"
    ln -sfn "$item" "$HOME/.config/$name"
    log_success "Linked .config/$name"
done

# Home-level files
ln -sf "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
log_success "Linked .zshrc"

# Claude commands and settings (into existing ~/.claude/)
ln -sfn "$SCRIPT_DIR/.claude/commands" "$HOME/.claude/commands"
ln -sf "$SCRIPT_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
log_success "Linked .claude/commands and settings.json"

# Install Tmux Plugin Manager (TPM) if not installed
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    log_info "Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
    log_success "TPM installed. Press prefix + I in tmux to install plugins"
else
    log_success "TPM already installed"
fi

# Source zshrc if using zsh
if [ -n "$ZSH_VERSION" ]; then
    log_info "Sourcing .zshrc..."
    source "$HOME/.zshrc" || log_warning "Could not source .zshrc (you may need to restart your shell)"
fi

log_success "Installation complete!"
echo ""
log_info "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open Kitty terminal"
echo "  3. Open tmux and press prefix + I to install tmux plugins"
echo "  4. Open Neovim - plugins should auto-install on first run"
echo "  5. Grant necessary permissions to Aerospace and Karabiner-Elements in System Settings"
echo "  6. Start Aerospace: open -a AeroSpace"
echo "  7. Start SketchyBar: brew services start sketchybar"
echo ""
log_warning "You may need to log out and log back in for all changes to take effect"
