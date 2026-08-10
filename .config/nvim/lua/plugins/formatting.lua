return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    vim.tbl_extend("force", opts.formatters_by_ft, {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      liquid = { "prettier" },
      lua = { "stylua" },
      python = { "isort", "black" },
      go = { "gofmt", "goimports" },
      rust = { "rustfmt" },
      java = { "google-java-format" },
    })

    opts.format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    }

    return opts
  end,
  keys = {
    {
      "<leader>mp",
      function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end,
      mode = { "n", "v" },
      desc = "Format file or range (in visual mode)",
    },
  },
}
