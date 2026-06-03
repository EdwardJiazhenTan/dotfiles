# Node
export NVM_DIR="$HOME/.nvm"
export DOTFILES_NODE_VERSION="v22.22.3"
export DOTFILES_NODE_BIN="$NVM_DIR/versions/node/$DOTFILES_NODE_VERSION/bin"

if [[ -d "$DOTFILES_NODE_BIN" ]]; then
    path=("${(@)path:#$NVM_DIR/versions/node/*/bin}")
    path=("$DOTFILES_NODE_BIN" "${path[@]}")
    export PATH
    rehash 2>/dev/null || true
fi

if [[ -o interactive && -s "$NVM_DIR/nvm.sh" ]]; then
    command -v nvm >/dev/null 2>&1 || . "$NVM_DIR/nvm.sh"
    nvm use 22 >/dev/null
fi

if [[ -o interactive && -s "$NVM_DIR/bash_completion" ]]; then
    . "$NVM_DIR/bash_completion"
fi
