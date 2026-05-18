# Flash settings
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export NX_TUI=false

alias nx='pnpm nx'
alias sand='nx start sandbox'
alias se='nx setup environment'

# Create a flash worktree under .claude/worktrees (nx-ignored), bootstrap it, then open claude inside.
cwt() {
  if [[ -z "$1" ]]; then
    echo "usage: cwt <branch>"
    return 1
  fi
  local flash_root="$HOME/projects/flash"
  local branch="$1"
  local sanitized="${branch//\//+}"
  local wt_path="$flash_root/.claude/worktrees/$sanitized"

  if [[ ! -d "$wt_path" ]]; then
    mkdir -p "$flash_root/.claude/worktrees"
    git -C "$flash_root" worktree add "$wt_path" "$branch" 2>/dev/null \
      || git -C "$flash_root" worktree add "$wt_path" -b "$branch" \
      || return 1
  fi

  ( unset npm_config_prefix; "$flash_root/scripts/worktree-setup.sh" "$wt_path" ) || return 1

  cd "$wt_path" || return 1
  [ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh" && nvm use 2>/dev/null
  claude
}

# Remove a flash worktree created by cwt. Pass -f to force-remove dirty worktrees.
rwt() {
  local force=""
  if [[ "$1" == "-f" ]]; then
    force="--force"
    shift
  fi
  if [[ -z "$1" ]]; then
    echo "usage: rwt [-f] <branch>"
    return 1
  fi
  local flash_root="$HOME/projects/flash"
  local branch="$1"
  local sanitized="${branch//\//+}"
  local wt_path="$flash_root/.claude/worktrees/$sanitized"

  [[ "$PWD" == "$wt_path"* ]] && cd "$flash_root"

  git -C "$flash_root" worktree remove $force "$wt_path" || return 1
  git -C "$flash_root" worktree prune
  echo "✓ removed worktree: $wt_path"
}
