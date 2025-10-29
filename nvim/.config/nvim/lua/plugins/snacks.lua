return {
  -- Configure snacks.nvim picker to show hidden/ignored files
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,     -- Show hidden files
            no_ignore = true,  -- Show git-ignored files (includes untracked)
            follow = true,     -- Follow symlinks
          },
          grep = {
            hidden = true,     -- Search in hidden files
            no_ignore = true,  -- Search git-ignored files
          },
        },
      },
    },
  },
}
