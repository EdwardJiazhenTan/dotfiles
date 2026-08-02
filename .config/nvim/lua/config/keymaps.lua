-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- basic keymaps
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- toggle inlay hints
keymap.set("n", "<leader>i", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

-- exit terminal mode with Alt-n
keymap.set("t", "<A-n>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- double escape to exit terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- open oil with -
keymap.set("n", "-", "<cmd>Oil<CR>")

keymap.set({ "n", "x" }, "<leader>pa", function()
  require("util.pi").add_context()
end, { desc = "Add Context to Pi" })

keymap.set({ "n", "x" }, "<leader>pd", function()
  require("util.pi").add_diagnostics()
end, { desc = "Add Diagnostics to Pi" })

keymap.set({ "n", "x" }, "<leader>ph", function()
  require("util.pi").add_hover()
end, { desc = "Add LSP Hover to Pi" })

-- copy the current file's project-relative path
keymap.set("n", "<leader>yp", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("Current buffer has no file", vim.log.levels.WARN)
    return
  end

  local path = vim.fs.relpath(LazyVim.root(), file) or file
  vim.fn.setreg("+", path)
  vim.notify("Copied " .. path)
end, { desc = "Yank File Path" })

-- visual mode mappings
keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("v", "<leader>C", "gc", { desc = "Comment/uncomment selection", remap = true })
