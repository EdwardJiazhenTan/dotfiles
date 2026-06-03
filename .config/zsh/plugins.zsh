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

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

if command -v fzf &>/dev/null; then
    source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
    source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"

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
    '

    export _FZF_PREVIEW_CMD='bat --color=always --style=plain,numbers --line-range=:500 {}'
    export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD'"
fi

# --- Appearance & Shell UI ---
# Loaded last so its zle-keymap-select hook wraps any earlier plugin's widget,
# not the other way around (prevents FUNCNEST recursion with fzf).
eval "$(starship init zsh)"
