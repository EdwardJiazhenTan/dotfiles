local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "ed.plugins" },
  { import = "ed.plugins.lsp" },
  { import = "ed.plugins.dev-tools" },
  { import = "ed.plugins.editor" },
  { import = "ed.plugins.file-management" },
  { import = "ed.plugins.git" },
  { import = "ed.plugins.specialized" },
  { import = "ed.plugins.ui" },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
