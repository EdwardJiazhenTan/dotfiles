return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", build = ":MasonUpdate" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "tailwindcss",
          "gopls",
          "bashls",
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")

      -- Common on_attach function for all LSP servers
      local on_attach = function(client, bufnr)
        local keymap = vim.keymap.set
        local opts = { buffer = bufnr, silent = true }

        keymap("n", "gd", vim.lsp.buf.definition, opts)
        keymap("n", "gD", vim.lsp.buf.declaration, opts)
        keymap("n", "gr", vim.lsp.buf.references, opts)
        keymap("n", "K", vim.lsp.buf.hover, opts)
        keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end

      -- TypeScript/JavaScript Language Server
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
      })

      -- Tailwind CSS Language Server
      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
        },
        settings = {
          tailwindCSS = {
            classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidConfigPath = "error",
              invalidScreen = "error",
              invalidTailwindDirective = "error",
              invalidVariant = "error",
              recommendedVariantOrder = "warning",
            },
            validate = true,
          },
        },
      })

      -- ESLint Language Server
      lspconfig.eslint.setup({
        settings = {
          workingDirectories = { mode = "auto" },
          codeActionOnSave = {
            enable = true,
            mode = "all",
          },
          format = true,
          quiet = false,
          onIgnoredFiles = "off",
        },
        on_attach = function(client, bufnr)
          -- Apply common LSP keymaps
          on_attach(client, bufnr)

          -- ESLint-specific autocmd
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        root_dir = function(fname)
          -- Only activate if ESLint config files exist
          return lspconfig.util.root_pattern(
            "eslint.config.js",
            "eslint.config.mjs",
            "eslint.config.cjs",
            ".eslintrc.js",
            ".eslintrc.json",
            ".eslintrc"
          )(fname)
        end,
      })

      -- Go Language Server
      lspconfig.gopls.setup({
        on_attach = on_attach,
      })

      -- Bash Language Server
      lspconfig.bashls.setup({
        on_attach = on_attach,
      })
    end,
  },
}
