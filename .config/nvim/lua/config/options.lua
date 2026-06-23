vim.opt.showcmd = true
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.wildignore:append({ "/node_modules/*" })
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.signcolumn = "yes"

-- Disable session autoload on startup
vim.g.persistence_autoload = false
-- Disable autoformat
-- TODO: make this format with eslint rules and prettier rules
vim.g.autoformat = true
-- disable animations
vim.g.snacks_animate = false
--vim.opt.statuscolumn = "%s%=%l  "
-- Don't conceal
vim.opt.conceallevel = 0
