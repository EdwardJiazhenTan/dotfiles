-- ~/.config/nvim/lua/config/autocmds.lua

-- Disable Typst LSP rendering features
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function(ev)
    vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
    vim.opt_local.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and (client.name == "tinymist" or client.name == "typst_lsp") then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})
