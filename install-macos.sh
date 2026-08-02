#!/usr/bin/env bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { printf "%b[INFO]%b %s\n" "$BLUE" "$NC" "$1"; }
log_success() { printf "%b[SUCCESS]%b %s\n" "$GREEN" "$NC" "$1"; }
log_warning() { printf "%b[WARNING]%b %s\n" "$YELLOW" "$NC" "$1"; }
log_error() { printf "%b[ERROR]%b %s\n" "$RED" "$NC" "$1"; }

if [[ "${OSTYPE:-}" != darwin* ]]; then
    log_error "This script is for macOS only."
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

backup_if_exists() {
    local path="$1"
    if [[ -e "$path" && ! -L "$path" ]]; then
        local backup_path="${path}.backup.$(date +%Y%m%d_%H%M%S)"
        log_warning "Backing up $path to $backup_path"
        mv "$path" "$backup_path"
    fi
}

link_path() {
    local source="$1"
    local target="$2"

    mkdir -p "$(dirname "$target")"
    backup_if_exists "$target"
    ln -sfn "$source" "$target"
    log_success "Linked $target"
}

install_formula() {
    local package="$1"
    if brew list --formula "$package" &>/dev/null; then
        log_success "$package already installed"
        return
    fi

    log_info "Installing $package..."
    brew install "$package"
}

install_cask() {
    local package="$1"
    if brew list --cask "$package" &>/dev/null; then
        log_success "$package already installed"
        return
    fi

    log_info "Installing $package..."
    brew install --cask "$package"
}

log_info "Starting macOS dotfiles installation..."

if ! command -v brew &>/dev/null; then
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    log_success "Homebrew already installed"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

for package in \
    bat \
    fastfetch \
    fd \
    fzf \
    gh \
    git-delta \
    jq \
    lazygit \
    neovim \
    node@22 \
    pnpm \
    ripgrep \
    starship \
    tmux \
    tree \
    worktrunk \
    zoxide \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zsh-vi-mode; do
    install_formula "$package"
done

for package in \
    font-jetbrains-mono-nerd-font \
    ghostty; do
    install_cask "$package"
done

log_info "Linking dotfiles from $SCRIPT_DIR..."

for item in "$SCRIPT_DIR/.config"/*; do
    [[ -e "$item" ]] || continue
    link_path "$item" "$HOME/.config/$(basename "$item")"
done

link_path "$SCRIPT_DIR/.config/zsh/entrypoints/macos.zsh" "$HOME/.zshrc"
link_path "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
link_path "$SCRIPT_DIR/.config/lazygit/config.yml" "$HOME/Library/Application Support/lazygit/config.yml"
link_path "$SCRIPT_DIR/.claude/commands" "$HOME/.claude/commands"

if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
    log_info "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
else
    log_success "TPM already installed"
fi

log_success "Installation complete."
log_info "Next steps:"
printf "  1. Restart your terminal or run: source ~/.zshrc\n"
printf "  2. Open tmux and press prefix + I to install tmux plugins\n"
