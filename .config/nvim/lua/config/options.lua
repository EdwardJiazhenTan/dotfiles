vim.opt.showcmd = true
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.wildignore:append({ "/node_modules/*" })
vim.opt.cursorline = false

-- Disable session autoload on startup
vim.g.persistence_autoload = false
-- disable animations
vim.g.snacks_animate = false
vim.opt.statuscolumn = ""
