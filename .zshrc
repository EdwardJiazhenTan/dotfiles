
# Homebrew (Initialize first so 'brew --prefix' works)
if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    BREW_PREFIX=$(brew --prefix)
fi

# Editor
export EDITOR='nvim'
export VISUAL='nvim'
export ENABLE_IDE_INTEGRATION=true

# vim mode
bindkey -v

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

    # --- Plugins (Homebrew on macOS, system packages on Linux) ---
    # Autosuggestions
    for _p in \
        "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
        "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
        "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"; do
        [[ -r "$_p" ]] && source "$_p" && break
    done
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585858,underline"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)

    # Syntax Highlighting
    for _p in \
        "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
        "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
        "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"; do
        [[ -r "$_p" ]] && source "$_p" && break
    done

    if command -v zoxide &>/dev/null; then
      eval "$(zoxide init zsh)"
    fi

    if command -v fzf &>/dev/null; then
        for _p in \
            "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" \
            "/usr/share/fzf/key-bindings.zsh" \
            "/usr/share/doc/fzf/examples/key-bindings.zsh"; do
            [[ -r "$_p" ]] && source "$_p" && break
        done
        for _p in \
            "$BREW_PREFIX/opt/fzf/shell/completion.zsh" \
            "/usr/share/fzf/completion.zsh" \
            "/usr/share/doc/fzf/examples/completion.zsh"; do
            [[ -r "$_p" ]] && source "$_p" && break
        done
        unset _p
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

export PATH="/Users/etan/downloads/git-fuzzy/bin:$PATH"

# Added by LM Studio CLI tool (lms)
export PATH="$PATH:/Users/etan/.lmstudio/bin"

# bun completions
[ -s "/home/ed/.bun/_bun" ] && source "/home/ed/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
