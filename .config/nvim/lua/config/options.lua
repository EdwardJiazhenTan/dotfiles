vim.opt.showcmd = true
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.wildignore:append({ "/node_modules/*" })
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Disable session autoload on startup
vim.g.persistence_autoload = false
-- Disable autoformat
vim.g.autoformat = false
-- disable animations
vim.g.snacks_animate = false
vim.opt.statuscolumn = ""
-- Don't conceal markdown markup (**, `, etc.) — keep symbols visible
vim.opt.conceallevel = 0
