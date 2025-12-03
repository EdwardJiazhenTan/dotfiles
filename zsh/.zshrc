# ===============================================
# ZSH Configuration File (macOS Version)
# ===============================================
# ===============================================
# ZSH AUTOSUGGESTIONS Configuration
# ===============================================
if [[ -r "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


# Configure suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585858,underline"

# Configure suggestion strategy
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Autosuggestion key bindings
bindkey '^f' autosuggest-accept          # Ctrl+f accept suggestion
bindkey '^j' autosuggest-accept          # Ctrl+j accept suggestion (extra option)

# ===============================================
# History Settings
# ===============================================
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# ===============================================
# Key Bindings
# ===============================================
# Use vi mode (set before other bindings)
bindkey -v

# History search in vi mode
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ===============================================
# ZOXIDE Configuration
# ===============================================
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# ===============================================
# FZF Configuration
# ===============================================
if command -v fzf &> /dev/null; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"

    # FZF theme and options
    export FZF_DEFAULT_OPTS="
    --height 40% 
    --layout=reverse 
    --border 
    --inline-info
    --color=fg:#d0d0d0,bg:#121212,hl:#5f87af
    --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff
    --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
    --color=marker:#87ff00,spinner:#af5fff,header:#87afaf
    --preview-window=:hidden
    --bind='?:toggle-preview'
    "
    
    # Use fd instead of find (if fd is installed)
    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
    fi

    # Use bat as preview tool
    if command -v bat &> /dev/null; then
        export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
        export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
    fi
fi

# ===============================================
# ZSH SYNTAX HIGHLIGHTING Configuration
# ===============================================
if [[ -r "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # Syntax highlighting color configuration
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

    # Main syntax highlighting styles
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[alias]=fg=green
    ZSH_HIGHLIGHT_STYLES[builtin]=fg=green
    ZSH_HIGHLIGHT_STYLES[function]=fg=green
    ZSH_HIGHLIGHT_STYLES[command]=fg=green
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[commandseparator]=none
    ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=green
    ZSH_HIGHLIGHT_STYLES[path]=fg=blue
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[assign]=none
    ZSH_HIGHLIGHT_STYLES[redirection]=none
    ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
    
    # Bracket highlighting
    ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold

    # Cursor highlighting
    ZSH_HIGHLIGHT_STYLES[cursor]=standout
fi

# ===============================================
# Completion System Configuration
# ===============================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' rehash true

# ===============================================
# Environment Variables
# ===============================================

# Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Path
export PATH="$HOME/.local/bin:$PATH"

# API Keys (recommend moving to a separate private file)
if [[ -f ~/.env ]]; then
    source ~/.env
fi

# ===============================================
# Conditional Loading
# ===============================================

# NVM initialization
if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# starship settings
eval "$(starship init zsh)"

# Homebrew path (Apple Silicon Mac)
if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH="/Library/TeX/texbin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Set Java 21 as default
export PATH="/opt/homebrew/opt/openjdk@25/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@25"

# Send bell on command complete for kitty notifications
precmd() { echo -ne '\a' }

# run fastfetch on each startup
fastfetch

# opencode
export PATH=/Users/etan/.opencode/bin:$PATH
