# vim mode
bindkey -v

# --- Key Bindings ---
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^f' autosuggest-accept
bindkey '^j' autosuggest-accept

fzf-git-branch-checkout() {
    git rev-parse --is-inside-work-tree &>/dev/null || return
    local branch
    branch=$(git branch --format='%(refname:short)' | fzf --height=40% --reverse) || return
    BUFFER="git checkout $branch"
    zle accept-line
}
zle -N fzf-git-branch-checkout
bindkey '^g' fzf-git-branch-checkout

# --- History Settings ---
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_find_no_dups

# --- Completion System ---
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
autoload -Uz compinit && compinit

# Send bell on command complete for kitty notifications
precmd() { echo -ne '\a' }
