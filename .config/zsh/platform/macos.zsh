if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
elif command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
fi

if command -v brew >/dev/null 2>&1; then
    export BREW_PREFIX="$(brew --prefix)"
    export PATH="$BREW_PREFIX/opt/node@22/bin:$PATH"
    export PATH="$BREW_PREFIX/opt/openjdk@17/bin:$PATH"
    export CPPFLAGS="-I$BREW_PREFIX/opt/openjdk@17/include"

    export ZSH_AUTOSUGGESTIONS_FILE="$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    export ZSH_SYNTAX_HIGHLIGHTING_FILE="$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    export FZF_KEY_BINDINGS_FILE="$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
    export FZF_COMPLETION_FILE="$BREW_PREFIX/opt/fzf/shell/completion.zsh"
fi

export PATH="/Library/TeX/texbin:$PATH"

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

if [[ -n "${BREW_PREFIX:-}" && -d "$BREW_PREFIX/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home" ]]; then
    export JAVA_HOME="$BREW_PREFIX/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
fi

if [[ -d "$HOME/Library/Android/sdk" ]]; then
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"
fi
