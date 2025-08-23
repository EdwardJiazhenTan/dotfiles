return {
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim", -- Add twilight as a dependency
    },
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
        options = {
          -- signcolumn = "no",
          -- number = false,
          -- relativenumber = false,
          -- cursorline = false,
          -- cursorcolumn = false,
          -- foldcolumn = "0",
          -- list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = true }, -- Enable twilight integration
        gitsigns = { enabled = true }, -- Disable gitsigns in zen mode
        tmux = { enabled = false },
        kitty = {
          enabled = false,
          font = "+4", -- font size increment
        },
      },
      on_open = function(win)
        -- Disable linting and auto-suggestions
        vim.lsp.buf_detach_client(vim.api.nvim_get_current_buf(), 0) -- Detaches all LSP clients
        vim.b.cmp_enabled = false                                    -- Disable auto-completion for nvim-cmp
      end,
      on_close = function()
        -- Re-enable linting and auto-suggestions
        vim.lsp.start_client({}) -- Restarts LSP clients (you may need to refine this)
        vim.b.cmp_enabled = true -- Re-enable auto-completion for nvim-cmp
      end,
    },
    config = function()
      require("zen-mode").setup({})

      vim.keymap.set("n", "<leader>zz", function()
        require("zen-mode").toggle()
      end, { noremap = true, silent = true, desc = "Toggle Zen Mode with Twilight" })
    end,
  },
  {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.25,        -- amount of dimming (0.0 = invisible, 1.0 = no dimming)
        color = { "Normal", "#ffffff" },
        term_bg = "#000000", -- if guibg=NONE, this will be used
        inactive = false,    -- when true, other windows will be fully dimmed
      },
      context = 15,          -- amount of lines we will try to show around the current line
      treesitter = true,     -- use treesitter when available for the filetype

      -- Choose your focus style:
      expand = {
        -- Function-based focus (shows entire functions/methods)
        "function",
        "function_definition",
        "function_declaration",
        "method",
        "method_definition",
        "arrow_function",
        "lambda",

        -- Code-block based focus (shows logical blocks)
        "class",
        "class_definition",
        "if_statement",
        "else_clause",
        "for_statement",
        "while_statement",
        "try_statement",
        "catch_clause",
        "switch_statement",
        "case_statement",

        -- Data structure focus
        "table",
        "dictionary",
        "list",
        "array",
        "object",

        -- Other useful contexts
        "comment",
        "string",
        "block",
        "do_block",
      },
      exclude = {}, -- exclude these filetypes
    },
    config = function(_, opts)
      require("twilight").setup(opts)
    end,
  },
}
