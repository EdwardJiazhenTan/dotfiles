source "$HOME/.config/zsh/platform/macos.zsh"
source "$HOME/.config/zsh/shared.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias nx='pnpm nx'
alias sand='nx start sandbox'
alias se='nx setup environment'
alias sv='nx setup:vault environment'
export NX_TUI=false
