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
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            { "mode", right_padding = 2 },
          },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              sources = { "nvim_lsp", "nvim_diagnostic" },
              sections = { "error", "warn", "info", "hint" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
          },
          lualine_x = {
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then
                  return ""
                end
                local names = {}
                for _, client in ipairs(clients) do
                  table.insert(names, client.name)
                end
                return " " .. table.concat(names, ", ")
              end,
            },
          },
          lualine_y = { "diff" },
          lualine_z = {
            { "location", left_padding = 2 },
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
