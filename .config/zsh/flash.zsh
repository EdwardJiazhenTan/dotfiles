# Flash settings
export NX_TUI=false

alias nx='pnpm nx'
alias sand='nx start sandbox'
alias se='nx setup environment'

# Create a flash worktree, bootstrap it, then enter it.
# Default: branch off develop.
# --pr <branch>: check out an existing PR branch (via gh) in the worktree.
cwt() {
  local pr_mode=""
  if [[ "$1" == "--pr" ]]; then
    pr_mode=1
    shift
  fi
  if [[ -z "$1" ]]; then
    echo "usage: cwt [--pr] <name>"
    return 1
  fi
  local flash_root="$HOME/projects/flash"
  local name="$1"
  local wt_path="$flash_root/.claude/worktrees/$name"

  if [[ ! -d "$wt_path" ]]; then
    mkdir -p "$flash_root/.claude/worktrees"
    git -C "$flash_root" worktree add --detach "$wt_path" develop || return 1
    if [[ -n "$pr_mode" ]]; then
      ( cd "$wt_path" && gh pr checkout "$name" ) || return 1
    fi
    ( cd "$wt_path" && unset npm_config_prefix && "$flash_root/scripts/worktree-setup.sh" ) || return 1
  fi

  cd "$wt_path" || return 1
}

# Remove a flash worktree created by cwt. Pass -f to force-remove dirty worktrees.
rwt() {
  local force=""
  if [[ "$1" == "-f" ]]; then
    force="--force"
    shift
  fi
  if [[ -z "$1" ]]; then
    echo "usage: rwt [-f] <name>"
    return 1
  fi
  local flash_root="$HOME/projects/flash"
  local name="$1"
  local wt_path="$flash_root/.claude/worktrees/$name"

  [[ "$PWD" == "$wt_path"* ]] && cd "$flash_root"

  git -C "$flash_root" worktree remove $force "$wt_path" || return 1
  git -C "$flash_root" worktree prune
  echo "✓ removed worktree: $wt_path"
}
