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

  -- Snacks picker: files changed vs origin/develop
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>gp",
        function()
          local base = "origin/develop"
          local out = vim.fn.systemlist({ "git", "diff", "--name-only", base .. "...HEAD" })
          if vim.v.shell_error ~= 0 then
            return vim.notify(table.concat(out, "\n"), vim.log.levels.ERROR)
          end
          local cwd = vim.fn.getcwd()
          local items = {}
          for _, f in ipairs(out) do
            if f ~= "" then
              items[#items + 1] = { text = f, file = f, cwd = cwd }
            end
          end
          if #items == 0 then
            return vim.notify("No files changed vs " .. base, vim.log.levels.INFO)
          end
          Snacks.picker.pick({
            items = items,
            format = "file",
            title = "Changed vs " .. base,
            confirm = function(picker, item)
              picker:close()
              if item then
                vim.cmd.edit(item.file)
              end
            end,
          })
        end,
        desc = "Pick file changed vs origin/develop",
      },
    },
  },
}
