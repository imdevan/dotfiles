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

-- Toggle comment state for each line individually in visual selection
function M.comment_swap()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  
  -- Get comment string for current filetype
  local commentstring = vim.bo.commentstring
  if commentstring == "" then
    print("No comment string defined for this filetype")
    return
  end
  
  -- Extract comment prefix (remove %s placeholder and trim whitespace)
  local comment_prefix = commentstring:gsub("%%s.*", ""):gsub("^%s*", ""):gsub("%s*$", "")
  
  -- Get buffer line count to avoid accessing invalid lines
  local buf_line_count = api.nvim_buf_line_count(0)
  
  -- Process each line in the selection
  for line_num = start_line, math.min(end_line, buf_line_count) do
    local lines = api.nvim_buf_get_lines(0, line_num - 1, line_num, false)
    if #lines == 0 then
      goto continue
    end
    
    local line_content = lines[1]
    if not line_content then
      goto continue
    end
    
    -- Skip empty lines
    if line_content:match("^%s*$") then
      goto continue
    end
    
    -- Check if line is commented (comment prefix appears after whitespace)
    local leading_space = line_content:match("^%s*") or ""
    local content_after_space = line_content:sub(#leading_space + 1)
    local is_commented = content_after_space:find("^" .. vim.pesc(comment_prefix))
    
    if is_commented then
      -- Uncomment: remove comment prefix and optional following space
      local pattern = "^(%s*)" .. vim.pesc(comment_prefix) .. "%s?"
      local uncommented = line_content:gsub(pattern, "%1")
      api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { uncommented })
    else
      -- Comment: add comment prefix after leading whitespace
      local commented = leading_space .. comment_prefix .. " " .. content_after_space
      api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { commented })
    end
    
    ::continue::
  end
end

return M
