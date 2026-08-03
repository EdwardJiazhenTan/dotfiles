# Autosuggestions
if [[ -r "${ZSH_AUTOSUGGESTIONS_FILE:-}" ]]; then
    source "$ZSH_AUTOSUGGESTIONS_FILE"
fi
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585858,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Syntax highlighting
if [[ -r "${ZSH_SYNTAX_HIGHLIGHTING_FILE:-}" ]]; then
    source "$ZSH_SYNTAX_HIGHLIGHTING_FILE"
fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

if command -v fzf &>/dev/null; then
    [[ -r "${FZF_KEY_BINDINGS_FILE:-}" ]] && source "$FZF_KEY_BINDINGS_FILE"
    [[ -r "${FZF_COMPLETION_FILE:-}" ]] && source "$FZF_COMPLETION_FILE"

    # strip-cwd-prefix removes the leading ./ from results
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

    export FZF_DEFAULT_OPTS='
      --height=60%
      --layout=reverse
      --border=rounded
      --prompt="  "
      --pointer="  "
      --preview-window=right:65%:wrap:border-left
      --color=fg:#D8DEE9,fg+:#ECEFF4,bg+:#3B4252,hl:#88C0D0,hl+:#8FBCBB,border:#4C566A
    '

    export _FZF_PREVIEW_CMD='bat --color=always --style=plain,numbers --line-range=:500 {}'
    export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD'"
fi

bindkey -v
KEYTIMEOUT=10
bindkey -M viins "^f" autosuggest-accept
(( $+widgets[fzf-history-widget] )) && bindkey -M viins "^r" fzf-history-widget

if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi
