
# Homebrew (Initialize first so 'brew --prefix' works)
if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    BREW_PREFIX=$(brew --prefix)
fi

# Editor
export EDITOR='zed'
export VISUAL='nvim'
export ENABLE_IDE_INTEGRATION=true

# Global Paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Users/etan/.opencode/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
export PATH="$BREW_PREFIX/opt/postgresql@16/bin:$PATH"
export PATH="$BREW_PREFIX/opt/openjdk@25/bin:$PATH"
export JAVA_HOME="$BREW_PREFIX/opt/openjdk@25"

# NVM Directory (Variable only)
export NVM_DIR="$HOME/.nvm"

# API Keys / Private Env
[[ -f ~/.env ]] && source ~/.env

if [[ -o interactive ]]; then

    # --- Appearance & Shell UI ---
    eval "$(starship init zsh)"

    # --- NVM Initialization ---
    # Moved here so it doesn't kill scripts with exit code 3
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    # --- Plugins (Using $BREW_PREFIX for speed) ---
    # Autosuggestions
    if [[ -r "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
        source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    fi
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585858,underline"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)

    # Syntax Highlighting
    if [[ -r "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
        source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    fi

    # Zoxide & FZF
    if command -v zoxide &>/dev/null; then
        eval "$(zoxide init zsh)"
        z() { __zoxide_z "$@" && lsd --tree --depth 1; }
    fi
    if command -v fzf &>/dev/null; then
        source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
        source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"
        export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info --color=fg:#d8dee9,bg:#2e3440,hl:#81a1c1 --color=fg+:#d8dee9,bg+:#3b4252,hl+:#81a1c1 --color=info:#88c0d0,prompt:#5e81ac,pointer:#bf616a --color=marker:#a3be8c,spinner:#b48ead,header:#81a1c1 --preview-window=:hidden --bind='?:toggle-preview'"
    fi

    # --- Key Bindings ---
    bindkey -e
    bindkey '^p' history-search-backward
    bindkey '^n' history-search-forward
    bindkey '^f' autosuggest-accept
    bindkey '^j' autosuggest-accept

    # --- History Settings ---
    HISTSIZE=5000
    SAVEHIST=5000
    HISTFILE=~/.zsh_history
    setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups

    # --- Completion System ---
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    zstyle ':completion:*' menu no
    zstyle ':completion:*' rehash true
    autoload -Uz compinit && compinit

    # --- Utilities ---
    # Send bell on command complete for kitty notifications
    precmd() { echo -ne '\a' }
fi

export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

ndiff() {
  if [[ $# -eq 0 ]]; then
    nvim -c "DiffviewOpen"
  else
    nvim -c "DiffviewOpen $1...HEAD --imply-local"
  fi
}

alias nx='pnpm nx'
alias sand='nx start sandbox'
alias se='nx setup environment'
export NX_TUI=false

