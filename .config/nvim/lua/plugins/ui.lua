-- UI enhancement plugins: colorscheme, colorizer, statusline
return {
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").setup({
        transparent = {
          bg = false,
          float = false,
        },
      })
      require("nordic").load()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bold = true })
          vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffffff" })
          vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#242933", underline = true, sp = "#4c566a" })
          vim.api.nvim_set_hl(0, "Visual", { bg = "#3F5071" })
          vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = "#d8dee9" })
          vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#d8dee9" })
          vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#88c0d0", bold = true })
          vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#BF616A" })
          vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#EBCB8B" })
          vim.api.nvim_set_hl(0, "@markup.strong", { fg = "#a3be8c", bold = true })
        end,
      })
      vim.cmd.colorscheme("nordic")
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
          a = { fg = colors.purple, bg = colors.bg, gui = "bold" },
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
        terminal = {
          a = { fg = colors.blue, bg = colors.bg, gui = "bold" },
        },
        inactive = {
          a = { fg = colors.dim, bg = colors.bg },
          b = { fg = colors.dim, bg = colors.bg },
          c = { fg = colors.dim, bg = colors.bg },
        },
      }

      vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })

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
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            {
              "filename",
              path = 2,
              color = { fg = colors.fg },
            },
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

  { "nvim-mini/mini.icons" },

  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        format = {
          input = { view = "cmdline_popup" },
          search_down = { view = "cmdline_popup" },
          search_up = { view = "cmdline_popup" },
        },
      },
      views = {
        hover = {
          border = {
            style = "rounded",
          },
        },
      },
    },
  },

  { "akinsho/bufferline.nvim", enabled = false },
}
