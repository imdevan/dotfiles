local M = {}

local api = vim.api
local cmd = vim.cmd

-- Word and character count of selection
function M.word_count()
  cmd('normal! "zy')
  local text = vim.fn.getreg("z")
  local chars = vim.fn.strlen(text)
  local words = #vim.split(text, "%s+", { trimempty = true })
  print("Words: " .. words .. " | Characters: " .. chars)
end

-- Create 5 lines below and move to the first
function M.create_space_below()
  cmd("5normal o")
  local current_line = api.nvim_win_get_cursor(0)[1]
  api.nvim_win_set_cursor(0, { current_line - 5, 0 })
end

-- Create 5 lines above
function M.create_space_above()
  cmd("5normal O")
end

-- Insert line (language-specific)
function M.insert_line()
  local filetype = vim.bo.filetype
  local current_line = api.nvim_win_get_cursor(0)[1]

  if filetype == "markdown" or filetype == "mdx" then
    -- Insert 80 dashes for Markdown/MDX
    local dash_line = string.rep("-", 80)
    api.nvim_buf_set_lines(0, current_line, current_line, false, { dash_line })
    api.nvim_win_set_cursor(0, { current_line + 1, 0 })
  else
    -- Insert 80 equals and comment for other languages
    local equals_line = string.rep("=", 80)
    api.nvim_buf_set_lines(0, current_line, current_line, false, { equals_line })
    -- Move to the new line and comment it
    api.nvim_win_set_cursor(0, { current_line + 1, 0 })
    -- Use schedule to ensure buffer update completes before commenting
    vim.schedule(function()
      cmd("normal gcc")
    end)
  end
end

return M
