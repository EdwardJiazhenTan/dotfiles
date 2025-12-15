-- Extra plugins for specific use cases: language-specific tools, etc.
return {
  -- Chinese input method auto-switching
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup({
        default_im_select = "com.apple.keylayout.US",
      })
    end,
  },

  -- LaTeX support
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = "latexmk"
    end,
  },

  -- LeetCode
  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = "magick_cli",
    },
  },
  {
    "kawre/leetcode.nvim",
    dependencies = {
      -- include a picker of your choice, see picker section for more details
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lang = "python3",
      image_support = true,
    },
  },

  -- Typst support
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },

  -- Markdown preview with Nordic theme
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = { "AlexvZyl/nordic.nvim" },

    config = function()
      -- Get Nordic color palette
      local nordic = require("nordic.colors")

      require("markview").setup({
        -- Use glow preset for headings
        markdown = {
          headings = require("markview.presets").headings.glow,
        },
      })
    end,
  },

  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },
}
