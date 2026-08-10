return {
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
}
