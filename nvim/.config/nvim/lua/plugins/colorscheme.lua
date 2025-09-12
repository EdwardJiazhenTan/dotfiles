return {
  {
    "shaunsingh/nord.nvim",
    config = function()
      -- Configure Nord with better contrast
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_disable_background = true
      vim.g.nord_italic = true
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = true

      require("nord").set()

      -- Custom highlight overrides for better visibility
      local highlights = {
        -- Visual selection
        Visual = { bg = "#4c566a", fg = "NONE" },
        --  VisualNOS = { bg = "#4c566a", fg = "NONE" },
      }

      for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
      end
    end,
  },
  -- Nord theme config for lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "nord",
          component_separators = "",
          section_separators = "",
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            { "mode", right_padding = 2 },
          },
          lualine_b = { "branch" },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { "diff" },
          lualine_z = {
            { "hostname", left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "aerial" },
      })
    end,
  },
}
