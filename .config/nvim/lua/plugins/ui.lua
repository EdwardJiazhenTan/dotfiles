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
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ebcb8b", bold = true })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#242933", underline = true, sp = "#4c566a" })
      vim.api.nvim_set_hl(0, "Visual", { bg = "#4C566A" })
      vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = "#4c566a" })
      vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#4c566a" })
      vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#88c0d0", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#BF616A" })
      vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#EBCB8B" })
      vim.api.nvim_set_hl(0, "@markup.strong", { fg = "#a3be8c", bold = true })
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
        inactive = {
          a = { fg = colors.dim, bg = colors.bg },
          b = { fg = colors.dim, bg = colors.bg },
          c = { fg = colors.dim, bg = colors.bg },
        },
      }

      vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })

      -- CodeCompanion activity indicator (animated spinner while a request is in-flight)
      local cc_spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      local cc_state = { active = false, frame = 1 }
      vim.api.nvim_create_autocmd("User", {
        pattern = { "CodeCompanionRequestStarted", "CodeCompanionRequestFinished" },
        callback = function(args)
          cc_state.active = args.match == "CodeCompanionRequestStarted"
        end,
      })
      local cc_timer = vim.uv.new_timer()
      cc_timer:start(0, 100, vim.schedule_wrap(function()
        if cc_state.active then
          cc_state.frame = (cc_state.frame % #cc_spinner) + 1
          require("lualine").refresh()
        end
      end))
      local function cc_status()
        if not cc_state.active then return "" end
        return cc_spinner[cc_state.frame] .. " thinking"
      end

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
          lualine_c = {
            { cc_status, color = { fg = colors.purple } },
          },
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
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_icons = false,
        show_close_icon = false,
        show_buffer_close_icons = false,
        diagnostics = false,
        separator_style = { "", "" },
        indicator = { style = "none" },
      },
      highlights = {
        fill = { bg = "#242933" },
        background = { bg = "#242933" },
        buffer_selected = { bg = "#242933", bold = true },
      },
    },
  },
}
