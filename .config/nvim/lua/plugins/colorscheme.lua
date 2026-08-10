return {

  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").load()
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
