# Editor
export EDITOR='nvim'
export VISUAL='nvim'
export ENABLE_IDE_INTEGRATION=true

# Global Paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Users/etan/.opencode/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
export PATH="$BREW_PREFIX/opt/postgresql@16/bin:$PATH"
export PATH="/Users/etan/downloads/git-fuzzy/bin:$PATH"
export PATH="$PATH:/Users/etan/.lmstudio/bin"

# API Keys / Private Env
[[ -f ~/.env ]] && source ~/.env
