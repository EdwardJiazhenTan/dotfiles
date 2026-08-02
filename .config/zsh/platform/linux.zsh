export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

if [[ -z "${JAVA_HOME:-}" && -d /usr/lib/jvm/default ]]; then
    export JAVA_HOME=/usr/lib/jvm/default
fi

if [[ -d "$HOME/Android/Sdk" ]]; then
    export ANDROID_HOME="$HOME/Android/Sdk"
    export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"
fi

export ZSH_AUTOSUGGESTIONS_FILE=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_SYNTAX_HIGHLIGHTING_FILE=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export FZF_KEY_BINDINGS_FILE=/usr/share/fzf/key-bindings.zsh
export FZF_COMPLETION_FILE=/usr/share/fzf/completion.zsh
export ZSH_VI_MODE_FILE=/usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
