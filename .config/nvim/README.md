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
└── plugins/
    ├── ui.lua        -- colorscheme, statusline, color highlighting
    ├── editor.lua    -- navigation, terminal, AI integration
    ├── lsp.lua       -- LSP, completion, Mason tools
    └── extra.lua     -- language-specific (Typst)
```

## Plugins

### UI
- **nordic.nvim** — Nord-based colorscheme (transparent bg off)
- **lualine.nvim** — minimal statusline matching tmux Nord palette; shows mode initial + diagnostics + active LSP clients
- **nvim-highlight-colors** — inline color swatches with Tailwind support

### Editor
- **oil.nvim** — file browser (`-` to open)
- **flash.nvim** — jump/treesitter motion (`s` / `S`)
- **nvim-surround** — surround text objects
- **vim-tmux-navigator** — `<C-h/j/k/l>` across nvim splits and tmux panes
- **claudecode.nvim** — Claude Code integration (`<C-,>` / `<leader>a*`)
- **yank-for-claude.nvim** — yank with file reference for Claude (`<leader>y/Y`)
- **trouble.nvim** — diagnostics/quickfix panel (`<leader>x*`)
- **diffview.nvim** — git diff/history viewer (`<leader>gD/gH/gr`)

### LSP / Completion
- **blink.cmp** — completion (super-tab preset, rounded borders, no ghost text)
- **nvim-lspconfig** — LSP config; inlay hints off, virtual text off, underline diagnostics
- **Mason** extras: `luacheck`, `shellcheck`, `shfmt`, `tailwindcss-language-server`, `css-lsp`, `jdtls`, `checkstyle`
- **vtsls** — TypeScript/JS server with workspace SDK, fuzzy match, 8 GB memory cap

### Extra
- **typst-preview.nvim** — live Typst preview

## Key Keymaps

| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `<leader>w` | Save |
| `<leader>q` | Quit (no save) |
| `<leader>nh` | Clear search highlights |
| `<leader>sv/sh` | Split vertical/horizontal |
| `-` | Open Oil (file browser) |
| `s` / `S` | Flash jump / treesitter |
| `<C-,>` | Focus Claude Code |
| `<leader>ac` | Toggle Claude |
| `<leader>ab` | Add buffer to Claude |
| `<leader>as` | Send selection to Claude (visual) / add file (file browser) |
| `<leader>aa/ad` | Accept/deny Claude diff |
| `<leader>y/Y` | Yank for Claude (reference / with content) |
| `<A-i>` | Toggle inlay hints |
| `<leader>gD` | Diffview unstaged |
| `<leader>gH` | Diffview file history |
| `<leader>gr` | Diffview review vs `origin/develop` |
