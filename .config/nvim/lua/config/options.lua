vim.opt.showcmd = true
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.wildignore:append({ "/node_modules/*" })
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.signcolumn = "yes"
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Disable session autoload on startup
vim.g.persistence_autoload = false
-- Disable autoformat
-- TODO: make this format with eslint rules and prettier rules
vim.g.autoformat = true
vim.g.lazyvim_eslint_auto_format = false
vim.g.lazyvim_ts_lsp = "tsgo"
-- disable animations
vim.g.snacks_animate = false
--vim.opt.statuscolumn = "%s%=%l  "
-- Don't conceal
vim.opt.conceallevel = 0
