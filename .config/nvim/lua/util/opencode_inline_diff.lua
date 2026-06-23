local M = {}

local NAMESPACE = vim.api.nvim_create_namespace("opencode_inline_diff")

---@type table<string, { win: integer, buf: integer, prev_buf: integer? }>
local active = {}

---Prefer the current window if it's a normal editor buffer, otherwise pick the
---leftmost non-float, non-special window in the current tabpage.
---@return integer? win
local function find_editor_win()
  local cur = vim.api.nvim_get_current_win()
  local cur_buf = vim.api.nvim_win_get_buf(cur)
  local cur_cfg = vim.api.nvim_win_get_config(cur)
  if cur_cfg.relative == "" and vim.bo[cur_buf].buftype == "" then
    return cur
  end

  local candidates = {}
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative == "" and vim.bo[buf].buftype == "" then
      table.insert(candidates, win)
    end
  end
  if #candidates == 0 then
    return nil
  end
  table.sort(candidates, function(a, b)
    return vim.api.nvim_win_get_position(a)[2] < vim.api.nvim_win_get_position(b)[2]
  end)
  return candidates[1]
end

---@param diff string
---@return { old_start: integer, old_count: integer, new_start: integer, new_count: integer, lines: string[] }[]
local function parse_unified_diff(diff)
  local hunks = {}
  local current
  for line in vim.gsplit(diff, "\n", { plain = true }) do
    if line:match("^@@ ") then
      local old_start, old_count, new_start, new_count = line:match("^@@ %-(%d+),?(%d*) %+(%d+),?(%d*) @@")
      if old_start then
        current = {
          old_start = tonumber(old_start),
          old_count = old_count ~= "" and tonumber(old_count) or 1,
          new_start = tonumber(new_start),
          new_count = new_count ~= "" and tonumber(new_count) or 1,
          lines = {},
        }
        table.insert(hunks, current)
      end
    elseif current then
      local prefix = line:sub(1, 1)
      if prefix == " " or prefix == "-" or prefix == "+" then
        table.insert(current.lines, line)
      end
    end
  end
  return hunks
end

---@param hunks table[]
---@return string[]
local function added_lines(hunks)
  local lines = {}
  for _, hunk in ipairs(hunks) do
    for _, line in ipairs(hunk.lines) do
      if line:sub(1, 1) == "+" then
        table.insert(lines, line:sub(2))
      end
    end
  end
  return lines
end

---@param buf integer
---@param hunks table[]
---@return integer focus_line
local function render(buf, hunks)
  vim.api.nvim_buf_clear_namespace(buf, NAMESPACE, 0, -1)
  local total_lines = vim.api.nvim_buf_line_count(buf)

  for _, hunk in ipairs(hunks) do
    local last_orig_line = hunk.old_count == 0 and hunk.old_start or (hunk.old_start - 1)
    local pending = {}

    local function flush()
      if #pending == 0 then
        return
      end
      local virt_lines = {}
      for _, text in ipairs(pending) do
        table.insert(virt_lines, { { text, "DiffAdd" } })
      end
      if last_orig_line >= 1 and last_orig_line <= total_lines then
        vim.api.nvim_buf_set_extmark(buf, NAMESPACE, last_orig_line - 1, 0, {
          virt_lines = virt_lines,
        })
      else
        vim.api.nvim_buf_set_extmark(buf, NAMESPACE, 0, 0, {
          virt_lines = virt_lines,
          virt_lines_above = true,
        })
      end
      pending = {}
    end

    for _, line in ipairs(hunk.lines) do
      local prefix = line:sub(1, 1)
      local content = line:sub(2)
      if prefix == " " then
        flush()
        last_orig_line = last_orig_line + 1
      elseif prefix == "-" then
        flush()
        last_orig_line = last_orig_line + 1
        if last_orig_line >= 1 and last_orig_line <= total_lines then
          vim.api.nvim_buf_set_extmark(buf, NAMESPACE, last_orig_line - 1, 0, {
            line_hl_group = "DiffDelete",
          })
        end
      elseif prefix == "+" then
        table.insert(pending, content)
      end
    end
    flush()
  end

  return hunks[1] and hunks[1].old_start or 1
end

---@param event opencode.server.Event
---@param server opencode.server.Server
function M.diff(event, server)
  local opts = require("opencode.config").opts.events.permissions or {}

  if event.type == "permission.asked" and event.properties.permission == "edit" then
    local idle_delay_ms = opts.idle_delay_ms or 1000
    vim.notify(
      "`opencode` requested permission — awaiting idle…",
      vim.log.levels.INFO,
      { title = "opencode", timeout = idle_delay_ms }
    )
    require("opencode.util").on_user_idle(idle_delay_ms, function()
      local diff = event.properties.metadata and event.properties.metadata.diff
      local filepath = event.properties.metadata and event.properties.metadata.filepath
      local request_id = event.properties.id

      if not diff or not filepath then
        vim.notify("opencode edit request missing diff or filepath", vim.log.levels.ERROR, { title = "opencode" })
        return
      end

      local hunks = parse_unified_diff(diff)
      if #hunks == 0 then
        vim.notify("Could not parse opencode edit diff", vim.log.levels.WARN, { title = "opencode" })
        return
      end

      local target_win = find_editor_win()
      local prev_buf
      local buf
      if target_win then
        prev_buf = vim.api.nvim_win_get_buf(target_win)
        buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_win_set_buf(target_win, buf)
        vim.api.nvim_set_current_win(target_win)
      else
        vim.cmd("tabnew")
        buf = vim.api.nvim_get_current_buf()
        target_win = vim.api.nvim_get_current_win()
      end

      local is_new_file = vim.fn.filereadable(filepath) == 0
      local content = is_new_file and added_lines(hunks) or vim.fn.readfile(filepath)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

      local short_id = request_id:sub(-6)
      local name = string.format("[opencode-diff %s] %s", short_id, filepath)
      pcall(vim.api.nvim_buf_set_name, buf, name)
      vim.bo[buf].buftype = "nofile"
      vim.bo[buf].bufhidden = "wipe"
      vim.bo[buf].swapfile = false
      vim.bo[buf].filetype = vim.filetype.match({ filename = filepath }) or ""
      vim.bo[buf].modifiable = false

      local focus_line = 1
      if is_new_file then
        vim.api.nvim_buf_clear_namespace(buf, NAMESPACE, 0, -1)
        for i = 1, vim.api.nvim_buf_line_count(buf) do
          vim.api.nvim_buf_set_extmark(buf, NAMESPACE, i - 1, 0, {
            line_hl_group = "DiffAdd",
          })
        end
      else
        focus_line = render(buf, hunks)
      end
      local target_line = math.max(1, math.min(focus_line, vim.api.nvim_buf_line_count(buf)))
      vim.api.nvim_win_set_cursor(0, { target_line, 0 })

      active[request_id] = { win = target_win, buf = buf, prev_buf = prev_buf }

      local function permit(reply)
        server:permit(request_id, reply)
      end

      vim.keymap.set("n", "oa", function()
        permit("once")
      end, { buffer = buf, desc = "Accept opencode edit" })
      vim.keymap.set("n", "or", function()
        permit("reject")
      end, { buffer = buf, desc = "Reject opencode edit" })
      vim.keymap.set("n", "]c", function()
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        for _, h in ipairs(hunks) do
          if h.old_start > cur then
            vim.api.nvim_win_set_cursor(0, { math.min(h.old_start, vim.api.nvim_buf_line_count(buf)), 0 })
            return
          end
        end
      end, { buffer = buf, desc = "Next opencode hunk" })
      vim.keymap.set("n", "[c", function()
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        local prev
        for _, h in ipairs(hunks) do
          if h.old_start < cur then
            prev = h.old_start
          else
            break
          end
        end
        if prev then
          vim.api.nvim_win_set_cursor(0, { prev, 0 })
        end
      end, { buffer = buf, desc = "Prev opencode hunk" })

      vim.api.nvim_create_autocmd("BufWipeout", {
        buffer = buf,
        once = true,
        callback = function()
          active[request_id] = nil
        end,
      })
    end)
  elseif event.type == "permission.replied" then
    local request_id = event.properties.requestID
    local s = active[request_id]
    if s then
      local diff_still_active = vim.api.nvim_win_is_valid(s.win)
        and vim.api.nvim_win_get_buf(s.win) == s.buf
      if diff_still_active and s.prev_buf and vim.api.nvim_buf_is_valid(s.prev_buf) then
        vim.api.nvim_win_set_buf(s.win, s.prev_buf)
      elseif vim.api.nvim_buf_is_valid(s.buf) then
        pcall(vim.api.nvim_buf_delete, s.buf, { force = true })
      end
    end
    active[request_id] = nil
  end
end

function M.setup()
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("OpencodeInlineDiff", { clear = true }),
    pattern = { "OpencodeEvent:permission.asked", "OpencodeEvent:permission.replied" },
    callback = function(args)
      ---@type opencode.server.Event
      local event = args.data.event
      ---@type string
      local url = args.data.url

      local opts = require("opencode.config").opts.events.permissions or {}
      if not opts.enabled then
        return
      end

      require("opencode.server")
        .new(url)
        :next(function(server)
          M.diff(event, server)
        end)
        :catch(function(err)
          if err then
            vim.notify("Failed to diff `opencode` edit request: " .. err, vim.log.levels.ERROR, { title = "opencode" })
          end
        end)
    end,
    desc = "Inline diff for opencode edit requests",
  })
end

return M
