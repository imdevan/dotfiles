local M = {}

local fn = vim.fn
local api = vim.api

local IMPLEMENT_TASK_PROMPT = "implement this task, and only this task, and mark complete if appropriate: "

-- Copy file path and line number
function M.copy_file_path()
  local filepath = fn.expand("%:.")
  local line_num = api.nvim_win_get_cursor(0)[1]
  local content = filepath .. ":" .. line_num
  fn.setreg("+", content)
  vim.notify("File and line copied", vim.log.levels.INFO)
end

-- "Implement" at file path
function M.implement_at_file_path(extra, extra_notif)
  local extra_notif = extra_notif or ""
  local filepath = fn.expand("%:p")
  local line_num = api.nvim_win_get_cursor(0)[1]
  local line_content = api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
  local content = IMPLEMENT_TASK_PROMPT .. "\n" .. filepath .. ":" .. line_num .. "\n" .. line_content .. "\n"

  if extra and extra ~= "" then
    content = content .. " " .. extra
  end

  fn.setreg("+", content)
  vim.notify("Implement at file path copied" .. extra_notif, vim.log.levels.INFO)
end

function M.implement_at_file_path_kiro()
  M.implement_at_file_path("ignore .kiro/steering instructions", "(for kiro)")
end

-- Copy file path and line range (for visual selection)
function M.copy_file_path_range()
  local filepath = fn.expand("%:.")
  local start_line = fn.line("v")
  local end_line = fn.line(".")

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local content = start_line == end_line and filepath .. ":" .. start_line
    or filepath .. ":" .. start_line .. "-" .. end_line

  fn.setreg("+", content)
  vim.notify("File and lines copied", vim.log.levels.INFO)
end

-- Delete file
function M.delete_file()
  local file = vim.fn.expand("%:p")
  if file == "" then
    return
  end

  vim.fn.delete(file)
  vim.cmd("bdelete!")
end

-- Delete file and close
function M.delete_file_and_close()
  local file = vim.fn.expand("%:p")
  if file == "" then
    return
  end

  vim.fn.delete(file)
  vim.cmd("qa!")
end

return M
