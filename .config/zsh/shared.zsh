source "$HOME/.config/zsh/exports.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/flash.zsh"

if [[ -o interactive ]]; then
    source "$HOME/.config/zsh/general.zsh"
    source "$HOME/.config/zsh/plugins.zsh"
fi

if command -v wt >/dev/null 2>&1; then
    eval "$(command wt config shell init zsh)"
fi
