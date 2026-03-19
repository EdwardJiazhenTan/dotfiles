-- UI enhancement plugins: colorscheme, colorizer, statusline
return {
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").setup({
        transparent = {
          bg = true,
          float = true,
        },
      })
      require("nordic").load()
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ebcb8b", bold = true })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#ebcb8b" })
      -- Diff highlights: transparent bg strips these, so set explicitly
      vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1e3a28", fg = "NONE" })
      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3a1e22", fg = "NONE" })
      vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1e2a3a", fg = "NONE" })
      vim.api.nvim_set_hl(0, "DiffText", { bg = "#2a3f5a", fg = "NONE", bold = true })
    end,
  },

  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        enable_named_colors = true,
        enable_tailwind = true,
      })
    end,
  },

  -- Lualine statusline (styled to match tmux: transparent, Nord palette, minimal)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local colors = {
        blue = "#88c0d0",
        green = "#a3be8c",
        purple = "#b48ead",
        dim = "#4c566a",
        fg = "#d8dee9",
        bg = "NONE",
      }

      local tmux_theme = {
        normal = {
          a = { fg = colors.blue, bg = colors.bg, gui = "bold" },
          b = { fg = colors.green, bg = colors.bg },
          c = { fg = colors.fg, bg = colors.bg },
          x = { fg = colors.fg, bg = colors.bg },
          y = { fg = colors.fg, bg = colors.bg },
          z = { fg = colors.purple, bg = colors.bg },
        },
        insert = {
          a = { fg = colors.green, bg = colors.bg, gui = "bold" },
        },
        visual = {
          a = { fg = colors.purple, bg = colors.bg, gui = "bold" },
        },
        command = {
          a = { fg = "#ebcb8b", bg = colors.bg, gui = "bold" },
        },
        inactive = {
          a = { fg = colors.dim, bg = colors.bg },
          b = { fg = colors.dim, bg = colors.bg },
          c = { fg = colors.dim, bg = colors.bg },
        },
      }

      require("lualine").setup({
        options = {
          theme = tmux_theme,
          component_separators = "",
          section_separators = "",
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(s)
                return s:sub(1, 1)
              end,
            },
          },
          lualine_b = {
            {
              "diagnostics",
              sources = { "nvim_lsp", "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {
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
              color = { fg = colors.dim },
            },
          },
          lualine_z = {},
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

  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
    },
  },

  { "nvim-mini/mini.icons" },
}
