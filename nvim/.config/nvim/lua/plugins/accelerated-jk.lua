return {
  "rainbowhxch/accelerated-jk.nvim",
  event = "VeryLazy",
  config = function()
    require("accelerated-jk").setup({
      -- Acceleration mode:
      -- "time_driven" - accelerates based on how long you hold the key
      -- "position_driven" - accelerates based on distance traveled
      mode = "time_driven",
      
      -- Enable acceleration for these keys
      enable_deceleration = false,
      
      -- Acceleration table - defines how fast it gets over time
      -- Format: { time_in_ms, lines_to_move }
      acceleration_motions = {},
      
      -- Table for deceleration (not used when enable_deceleration = false)
      deceleration_motions = {},
      
      -- Acceleration limit
      acceleration_limit = 150,
      
      -- Enable by default
      enable_acceleration = true,
    })

    -- Map j and k to accelerated versions
    vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)", { desc = "Accelerated j" })
    vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)", { desc = "Accelerated k" })
  end,
}
