# Neovim Config

Built on [LazyVim](https://lazyvim.github.io).

## Structure

```
lua/
├── config/
│   ├── keymaps.lua   -- custom keybindings
│   ├── options.lua   -- vim options / globals
│   ├── lazy.lua      -- lazy.nvim bootstrap
│   └── autocmds.lua  -- autocommands
├── plugins/
│   ├── ui.lua        -- colorscheme, statusline, bufferline, color highlighting
│   ├── editor.lua    -- navigation, file browser, formatting, markdown rendering
│   ├── git.lua       -- gitsigns, diffview
│   ├── lsp.lua       -- LSP, completion, Mason tools
│   └── extra.lua     -- language-specific (Typst)
└── util/
    ├── eslint.lua -- flat-config detection for conform
    └── pi.lua     -- Pi bridge and Neovim context integration
```

## Plugins

### UI
- **nordic.nvim** — Nord-based colorscheme with Nordic Blur cursor, active-line, and diagnostic gutter colors
- **lualine.nvim** — minimal statusline matching tmux Nord palette
- **dropbar.nvim** — keyboard-driven path and symbol breadcrumbs (`<leader>;`, `[;`, `];`)
- **bufferline.nvim** — minimal tab/buffer line, no icons or close buttons
- **nvim-highlight-colors** — inline color swatches with Tailwind support
- **mini.icons** — icon provider

### Editor
- **oil.nvim** — file browser (`-` to open), hidden files shown
- **flash.nvim** — jump/treesitter motion (`s` / `S` / `r` / `R`)
- **nvim-surround** — surround text objects (`gsa`, `gsd`, `gsr`)
- **nvim-ufo** — LSP-backed code folding (`zR` / `zM`)
- **vim-tmux-navigator** — `<C-h/j/k/l>` across nvim splits and tmux panes
- **trouble.nvim** — diagnostics/quickfix panel (`<leader>x*`)
- **render-markdown.nvim** — markdown rendering for buffers and CodeCompanion chat
- **snacks.nvim** — picker layout override (top-anchored, preview hidden)
- **conform.nvim** — formatter (`<leader>f`); ESLint flat-config aware for JS/TS

### Agent
- **Pi** — tmux-local agent bridge with Neovim context (`<leader>pa`)

### Git
- **gitsigns.nvim** — sign column + inline current-line blame
- **diffview.nvim** — git diff/history viewer (`<leader>gD/gH/gr`)

### LSP / Completion
- **blink.cmp** — completion with automatic type/documentation details (super-tab preset, no ghost text)
- **nvim-lspconfig** — LSP config; inlay hints off, virtual text off, underline diagnostics
- **Mason** extras: `shellcheck`, `shfmt`, `tailwindcss-language-server`, `css-lsp`, `jdtls`, `checkstyle`
- **tsgo** — native TypeScript/JS language server (LSP support is still in progress upstream)

### Extra
- **typst-preview.nvim** — live Typst preview
