# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]

# ===============================================
# ZSH 配置文件
# ===============================================

# Powerlevel10k 主题
if [[ -r "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme" ]]; then
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi
# ===============================================
# ZSH AUTOSUGGESTIONS 配置
# ===============================================
if [[ -r "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -r "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source $HOME/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# 禁用 p10k 设置 tmux 窗口标题
POWERLEVEL9K_TERM_SHELL_INTEGRATION=false

# 配置建议颜色 (在你的 kitty 主题中应该清晰可见)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585858,underline"

# 配置建议策略
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# 快捷键绑定
bindkey '^f' autosuggest-accept          # Ctrl+f 接受建议
bindkey '^]' autosuggest-execute         # Ctrl+] 执行建议
bindkey '^[f' autosuggest-accept-word    # Alt+f 接受一个单词
# 插件列表
plugins=(git sudo zsh-256color zsh-autosuggestions zsh-syntax-highlighting fzf-tab)

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
eval "$(zoxide init zsh)"

# ===============================================
# FZF 配置
# ===============================================
if command -v fzf &> /dev/null; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
    
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
# FZF-TAB 配置
# ===============================================
# 启用 fzf-tab
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# 配置预览
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'echo ${(P)word}'

# 配置组
zstyle ':fzf-tab:*' switch-group ',' '.'

# ===============================================
# ZSH SYNTAX HIGHLIGHTING 配置
# ===============================================
if [[ -r "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    
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
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
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
# 函数定义
# ===============================================

# 包管理函数
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]]; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# 检测 AUR 助手
if pacman -Qi yay &>/dev/null; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null; then
   aurhelper="paru"
fi

# 智能包安装函数
function in {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()

    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null; then
            arch+=("${pkg}")
        else
            aur+=("${pkg}")
        fi
    done

    if [[ ${#arch[@]} -gt 0 ]]; then
        sudo pacman -S "${arch[@]}"
    fi

    if [[ ${#aur[@]} -gt 0 ]]; then
        ${aurhelper} -S "${aur[@]}"
    fi
}

# 增强的 cd 函数
function cd() {
    if [ $# -eq 0 ]; then
        builtin cd && eza --icons --group-directories-first
    else
        builtin cd "$@" && eza --icons --group-directories-first
    fi
}

# Yazi 集成
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# ===============================================
# 别名定义
# ===============================================

# 基础别名
alias c='clear'
alias mkdir='mkdir -p'

# Eza 别名
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'
alias la='eza -la --icons=auto'

# 包管理别名
alias un='$aurhelper -Rns'
alias up='$aurhelper -Syu'
alias pl='$aurhelper -Qs'
alias pa='$aurhelper -Ss'
alias pc='$aurhelper -Sc'
alias po='$aurhelper -Qtdq | $aurhelper -Rns -'

# 导航别名
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'


# 其他别名
alias vc='code'
alias cat='bat'
alias find='fd'

# Neovim 别名
alias n='nvim'

# Git 别名
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline'

# ===============================================
# 环境变量
# ===============================================

# 编辑器
export EDITOR='nvim'
export VISUAL='nvim'

# 路径
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.lmstudio/bin:$PATH"

# API Keys (建议移到单独的私有文件中)
if [[ -f ~/.env ]]; then
    source ~/.env
fi

# ===============================================
# 条件加载
# ===============================================

# P10k 配置
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Conda 初始化
if [[ -f "/home/ed/miniconda3/etc/profile.d/conda.sh" ]]; then
    . "/home/ed/miniconda3/etc/profile.d/conda.sh"
fi

# NVM 初始化
if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi
