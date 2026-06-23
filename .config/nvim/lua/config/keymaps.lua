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

-- visual mode mappings
keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("v", "<leader>C", "gc", { desc = "Comment/uncomment selection", remap = true })
