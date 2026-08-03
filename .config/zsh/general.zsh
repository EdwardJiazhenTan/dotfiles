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

# Send bell on command complete for terminal notifications
precmd() { echo -ne '\a' }
