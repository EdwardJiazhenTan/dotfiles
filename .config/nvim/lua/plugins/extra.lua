-- Extra plugins for specific use cases: language-specific tools, etc.
return {

  -- Typst support
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },
}
