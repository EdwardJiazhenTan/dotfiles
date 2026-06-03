# Homebrew (Initialize first so 'brew --prefix' works)
if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    BREW_PREFIX=$(brew --prefix)
fi

source ~/.config/zsh/exports.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/flash.zsh
if [[ -o interactive ]]; then
    source ~/.config/zsh/general.zsh
    source ~/.config/zsh/plugins.zsh
fi
source ~/.config/zsh/node.zsh
