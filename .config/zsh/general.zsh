# --- Key Bindings ---
# zsh-vi-mode resets the viins/vicmd keymaps on init, so any bindkey set here
# would get clobbered. Defer custom binds until after the plugin initializes.
zvm_after_init_commands+=('
  bindkey "^p" history-search-backward
  bindkey "^n" history-search-forward
  bindkey "^f" autosuggest-accept
  bindkey "^j" autosuggest-accept
  (( $+widgets[fzf-history-widget] )) && bindkey "^r" fzf-history-widget
')

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

# Only changing the escape key to `jk` in insert mode, we still
# keep using the default keybindings `^[` in other modes
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
