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
      view = {
        default = { layout = "diff2_horizontal" },
        merge_tool = { layout = "diff3_mixed" },
        file_history = { layout = "diff2_horizontal" },
      },
      file_panel = {
        listing_style = "list",
      },
      hooks = {
        view_opened = function()
          vim.cmd("DiffviewToggleFiles")
        end,
      },
    },
  },
}
