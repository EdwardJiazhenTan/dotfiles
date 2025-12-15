-- Editor enhancement plugins: navigation, terminal, file finding, etc.
return {
  -- Accelerated j/k navigation
  {
    "rainbowhxch/accelerated-jk.nvim",
    event = "VeryLazy",
    config = function()
      require("accelerated-jk").setup({
        -- Acceleration mode:
        -- "time_driven" - accelerates based on how long you hold the key
        -- "position_driven" - accelerates based on distance traveled
        mode = "time_driven",

        -- Enable acceleration for these keys
        enable_deceleration = false,

        -- Acceleration table - defines how fast it gets over time
        -- Format: { time_in_ms, lines_to_move }
        acceleration_motions = {},

        -- Table for deceleration (not used when enable_deceleration = false)
        deceleration_motions = {},

        -- Acceleration limit
        acceleration_limit = 150,

        -- Enable by default
        enable_acceleration = true,
      })

      -- Map j and k to accelerated versions
      vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)", { desc = "Accelerated j" })
      vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)", { desc = "Accelerated k" })
    end,
  },

  -- Surround text objects
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  -- Tmux navigation
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "float",
        float_opts = { border = "curved" },
        insert_mappings = true,
        terminal_mappings = true,
      })

      vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "ToggleTerm" })
    end,
  },

  -- Trouble diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    opts = {
      focus = true,
    },
    cmd = "Trouble",
    keys = {
      { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
      { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
    },
  },

  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
      "folke/todo-comments.nvim",
      "folke/trouble.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local transform_mod = require("telescope.actions.mt").transform_mod

      -- Safely load trouble with error handling
      local trouble_ok, trouble = pcall(require, "trouble")
      local trouble_telescope_ok, trouble_telescope = pcall(require, "trouble.sources.telescope")

      -- or create your custom action
      local custom_actions = transform_mod({
        open_trouble_qflist = function(prompt_bufnr)
          if trouble_ok then
            trouble.toggle("quickfix")
          end
        end,
      })

      telescope.setup({
        defaults = {
          path_display = { "smart" },
          file_ignore_patterns = {},
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--no-ignore", -- This shows git-ignored files
            "--hidden", -- Search hidden files
          },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
              ["<C-t>"] = trouble_telescope_ok and trouble_telescope.open or actions.select_default,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = false, -- Show hidden files
            no_ignore = false, -- Show git-ignored files
            follow = true, -- Follow symlinks
          },
        },
      })

      telescope.load_extension("fzf")

      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
      keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
      keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
      keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
      keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    end,
  },

  -- Snacks picker configuration
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true, -- Show hidden files
            no_ignore = true, -- Show git-ignored files (includes untracked)
            follow = true, -- Follow symlinks
          },
          grep = {
            hidden = true, -- Search in hidden files
            no_ignore = true, -- Search git-ignored files
          },
        },
      },
    },
  },
}
