return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "main",
        path = vim.fn.expand("~/Notes/"), -- 确保路径正确展开
      },
    },
    
    preferred_link_style = "markdown",
  disable_frontmatter = false,    
    ui = {
      enable = true,
      update_debounce = 200,
      max_file_length = 5000,
    },
    
    attachments = {
      img_folder = "Assets",
    },
    
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    
    new_notes_location = "current_dir",
    
    -- 简化 note_id_func
    note_id_func = function(title)
      if title ~= nil then
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        return tostring(os.time())
      end
    end,
  },
  
  -- 简化快捷键配置
  keys = {
    { "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "New note", ft = "markdown" },
    { "<leader>nf", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch", ft = "markdown" },
    { "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "Search", ft = "markdown" },
  },
}
