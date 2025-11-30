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

# Install GNU Stow
if ! command -v stow &> /dev/null; then
    log_info "Installing GNU Stow..."
    brew install stow
    log_success "GNU Stow installed"
else
    log_success "GNU Stow already installed"
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

# Install SF Mono Nerd Font for better terminal experience
log_info "Installing Nerd Fonts..."
brew tap homebrew/cask-fonts
brew install --cask font-sf-mono-nerd-font || log_warning "Font already installed or unavailable"
brew install --cask font-jetbrains-mono-nerd-font || log_warning "Font already installed or unavailable"

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

log_info "Backing up existing configurations..."
backup_if_exists "$HOME/.config/kitty"
backup_if_exists "$HOME/.config/nvim"
backup_if_exists "$HOME/.config/tmux"
backup_if_exists "$HOME/.tmux.conf"
backup_if_exists "$HOME/.config/zed"
backup_if_exists "$HOME/.config/aerospace"
backup_if_exists "$HOME/.config/karabiner"
backup_if_exists "$HOME/.config/sketchybar"
backup_if_exists "$HOME/.config/fastfetch"
backup_if_exists "$HOME/.zshrc"

# Stow configurations
log_info "Symlinking configurations using GNU Stow..."

stow_package() {
    local package="$1"
    if [ -d "$package" ]; then
        log_info "Stowing $package..."
        stow -v "$package" 2>&1 | grep -v "BUG in find_stowed_path" || true
        log_success "$package stowed"
    else
        log_warning "Package $package not found, skipping..."
    fi
}

# Stow all packages
stow_package "kitty"
stow_package "nvim"
stow_package "tmux"
stow_package "zed"
stow_package "aerospace"
stow_package "sketchybar"
stow_package "spicetify"
stow_package "fastfetch"
stow_package "zsh"

# Note: Karabiner config is intentionally not stowed
# Everyone has different keyboard customization requirements
log_info "Karabiner-Elements installed but config not copied (customize yourself in the app)"

# Install Tmux Plugin Manager (TPM) if not installed
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    log_info "Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
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
