# ===============================================
# ZSH 配置文件 (macOS 版本)
# ===============================================
# ===============================================
# ZSH AUTOSUGGESTIONS 配置
# ===============================================
if [[ -r "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


# 配置建议颜色
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585858,underline"

# 配置建议策略
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Autosuggestion 快捷键绑定
bindkey '^f' autosuggest-accept          # Ctrl+f 接受建议
bindkey '^j' autosuggest-accept          # Ctrl+j 接受建议 (额外选项)

# ===============================================
# 历史设置
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
# 键绑定
# ===============================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ===============================================
# ZOXIDE 配置
# ===============================================
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# ===============================================
# FZF 配置
# ===============================================
if command -v fzf &> /dev/null; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
    
    # FZF 主题和选项
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
    
    # 使用 fd 替代 find (如果安装了 fd)
    if command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
    fi
    
    # 使用 bat 作为预览工具
    if command -v bat &> /dev/null; then
        export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
        export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
    fi
fi

# ===============================================
# ZSH SYNTAX HIGHLIGHTING 配置
# ===============================================
if [[ -r "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    
    # 语法高亮颜色配置
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
    
    # 主要语法高亮样式
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
    
    # 括号高亮
    ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
    
    # 光标高亮
    ZSH_HIGHLIGHT_STYLES[cursor]=standout
fi

# FZF theme
export FZF_DEFAULT_OPTS="--color=fg:#d8dee9,bg:#2e3440,hl:#81a1c1 \
--color=fg+:#d8dee9,bg+:#3b4252,hl+:#81a1c1 \
--color=info:#88c0d0,prompt:#5e81ac,pointer:#bf616a \
--color=marker:#a3be8c,spinner:#b48ead,header:#81a1c1"

# ===============================================
# 完成系统配置
# ===============================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' rehash true

# ===============================================
# 环境变量
# ===============================================

# 编辑器
export EDITOR='nvim'
export VISUAL='nvim'

# 路径
export PATH="$HOME/.local/bin:$PATH"

# API Keys (建议移到单独的私有文件中)
if [[ -f ~/.env ]]; then
    source ~/.env
fi

# Enable vi mode in zsh
bindkey -v

# ===============================================
# 条件加载
# ===============================================

# NVM 初始化
if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# starship settings
eval "$(starship init zsh)"

# Homebrew 路径 (Apple Silicon Mac)
if [[ -d "/opt/homebrew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
export PATH="/Library/TeX/texbin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Set Java 21 as default
export PATH="/opt/homebrew/opt/openjdk@25/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@25"

# run fastfetch on each startup
fastfetch
