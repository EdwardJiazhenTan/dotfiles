return {
  "akinsho/toggleterm.nvim",
  version = "*",                   -- 跟随最新 tag
  opts = {
    open_mapping      = [[<F12>]], -- Ctrl+\ 打开 / 隐藏
    direction         = "float",   -- 浮窗；可改 horizontal / vertical / tab
    float_opts        = { border = "curved" },
    insert_mappings   = true,      -- 插入模式也能触发
    terminal_mappings = true,      -- Terminal 模式也能触发
  },
}
