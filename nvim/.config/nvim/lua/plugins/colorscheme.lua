-- Colorscheme configuration
return {
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").load()

      -- Make relative line numbers brighter and more visible
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#81A1C1", bold = true })
      vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#88C0D0", bold = true })
      vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#88C0D0", bold = true })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#EBCB8B", bold = true })
    end,
  },
}
