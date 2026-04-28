return {
  -- Inline git blame
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_formatter = "  <author>, <author_time:%Y-%m-%d>",
      current_line_blame_opts = { delay = 300 },
    },
  },

  -- Diff view for git changes and code review
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    opts = {
      enhanced_diff_hl = true,
    },
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Diffview unstaged changes" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview file history" },
      {
        "<leader>gr",
        "<cmd>DiffviewOpen origin/develop...HEAD --imply-local<cr>",
        desc = "Diffview review vs develop",
      },
    },
  },
}
