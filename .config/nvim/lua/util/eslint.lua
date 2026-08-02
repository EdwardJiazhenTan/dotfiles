local M = {}

local CONFIG_NAMES = {
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.json",
}

function M.has_flat_config(bufnr)
  local fname = vim.api.nvim_buf_get_name(bufnr or 0)
  if fname == "" then
    return false
  end
  return vim.fs.find(CONFIG_NAMES, { upward = true, path = fname })[1] ~= nil
end

function M.has_config(ctx)
  return vim.fs.find(CONFIG_NAMES, { upward = true, path = ctx.filename })[1] ~= nil
end

return M
