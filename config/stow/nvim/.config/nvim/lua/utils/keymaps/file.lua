local M = {}

local fn = vim.fn
local api = vim.api

local IMPLEMENT_TASK_PROMPT =
  "implement this task, and only this task, and mark complete if appropriate: create sub tasks if neccessary to describe work completed"

-- local IMPLEMENT_TASK_PROMPT = "implement this task, and only this task, and mark complete if appropriate: "

-- Get current file path and line number
-- @param relative boolean: if true, returns relative path; if false, returns absolute path
-- @return string, number: filepath and line number
function M.get_file_path_and_line(relative)
  local filepath = relative and fn.expand("%:.") or fn.expand("%:p")
  local line_num = api.nvim_win_get_cursor(0)[1]
  return filepath, line_num
end

-- Copy file path and line number
function M.copy_file_path()
  local filepath, line_num = M.get_file_path_and_line(true)
  local content = filepath .. ":" .. line_num
  fn.setreg("+", content)
  vim.notify("File and line copied", vim.log.levels.INFO)
end

-- "Implement" at file path
function M.implement_at_file_path(extra, extra_notif)
  local extra_notif = extra_notif or ""
  local filepath = fn.expand("%:p")
  local mode = api.nvim_get_mode().mode
  
  local start_line, end_line, lines_content
  
  -- Check if in visual mode
  if mode == "v" or mode == "V" or mode == "\22" then
    start_line = fn.line("v")
    end_line = fn.line(".")
    
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    
    lines_content = api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  else
    -- Normal mode - single line
    start_line = api.nvim_win_get_cursor(0)[1]
    end_line = start_line
    lines_content = api.nvim_buf_get_lines(0, start_line - 1, start_line, false)
  end
  
  local line_ref = start_line == end_line and tostring(start_line) 
    or start_line .. "-" .. end_line
  
  local content = IMPLEMENT_TASK_PROMPT .. "\n" .. filepath .. ":" .. line_ref .. "\n" .. table.concat(lines_content, "\n") .. "\n"

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
