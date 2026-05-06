local M = {}

local FLAT_NAMES = { "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", "eslint.config.ts" }

function M.has_flat_config(bufnr)
  local fname = vim.api.nvim_buf_get_name(bufnr or 0)
  if fname == "" then
    return false
  end
  return vim.fs.find(FLAT_NAMES, { upward = true, path = fname })[1] ~= nil
end

return M
