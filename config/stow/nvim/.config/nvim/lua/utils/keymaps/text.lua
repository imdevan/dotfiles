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

-- Yank text between separator lines (e.g., ---, ===, etc.)
function M.yank_between_seperators()
  local current_line = api.nvim_win_get_cursor(0)[1]
  local total_lines = api.nvim_buf_line_count(0)

  -- Common separator patterns
  local separator_patterns = {
    "^%-%-%-+%s*$", -- --- (3 or more dashes)
    "^===+%s*$", -- === (3 or more equals)
    "^___+%s*$", -- ___ (3 or more underscores)
    "^%*%*%*+%s*$", -- *** (3 or more asterisks)
  }

  -- Function to check if a line is a separator
  local function is_separator(line_num)
    if line_num < 1 or line_num > total_lines then
      return false
    end
    local line = api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
    if not line then
      return false
    end
    for _, pattern in ipairs(separator_patterns) do
      if line:match(pattern) then
        return true
      end
    end
    return false
  end

  -- Find the separator above current line
  local start_line = nil
  for line_num = current_line - 1, 1, -1 do
    if is_separator(line_num) then
      start_line = line_num
      break
    end
  end

  -- Find the separator below current line
  local end_line = nil
  for line_num = current_line + 1, total_lines do
    if is_separator(line_num) then
      end_line = line_num
      break
    end
  end

  -- Check if we found both separators
  if not start_line or not end_line then
    print("Could not find separators above and below cursor")
    return
  end

  -- Yank the content between separators (excluding the separator lines)
  local content_start = start_line + 1
  local content_end = end_line - 1

  if content_start > content_end then
    print("No content between separators")
    return
  end

  -- Get the lines and yank them
  local lines = api.nvim_buf_get_lines(0, content_start - 1, content_end, false)

  if #lines == 0 then
    print("No content between separators")
    return
  end

  local text = table.concat(lines, "\n")

  -- Copy to multiple registers for maximum compatibility
  vim.fn.setreg("+", text, "l") -- System clipboard (linewise)
  vim.fn.setreg("*", text, "l") -- Selection clipboard (linewise)
  vim.fn.setreg('"', text, "l") -- Unnamed register (linewise)
  vim.fn.setreg("0", text, "l") -- Yank register (linewise)

  local line_count = #lines
  print("Yanked " .. line_count .. " line(s) between separators to clipboard")
end

-- Toggle comment state for each line individually in visual selection
function M.comment_swap()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Ensure start_line is always less than end_line (handles upward selection)
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

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

-- Convert entire line to title case, ignoring special characters
function M.line_to_title_case()
  local current_line_num = api.nvim_win_get_cursor(0)[1]
  local lines = api.nvim_buf_get_lines(0, current_line_num - 1, current_line_num, false)

  if #lines == 0 then
    return
  end

  local line = lines[1]

  -- Convert to title case: capitalize first letter of each word
  local title_cased = line:gsub("(%a)([%w_']*)", function(first, rest)
    return first:upper() .. rest:lower()
  end)

  api.nvim_buf_set_lines(0, current_line_num - 1, current_line_num, false, { title_cased })
end

-- Insert dash at the beginning of each line in selection
function M.insert_dash_at_line_start()
  -- Get visual selection range
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  
  -- Ensure start_line is always less than end_line
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  
  -- Get buffer line count to avoid accessing invalid lines
  local buf_line_count = api.nvim_buf_line_count(0)
  
  -- Process each line in the selection
  for line_num = start_line, math.min(end_line, buf_line_count) do
    local lines = api.nvim_buf_get_lines(0, line_num - 1, line_num, false)
    if #lines > 0 and lines[1] then
      local line_content = lines[1]
      -- Capture leading whitespace and insert "- " after it
      local leading_space = line_content:match("^%s*") or ""
      local content_after_space = line_content:sub(#leading_space + 1)
      local new_line = leading_space .. "- " .. content_after_space
      api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { new_line })
    end
  end
end

-- Trim whitespace around selected text
function M.trim_whitespace()
  -- Yank the visual selection to register z
  vim.cmd('normal! "zy')
  local selected_text = vim.fn.getreg("z")
  
  -- Trim whitespace
  local trimmed = selected_text:match("^%s*(.-)%s*$")
  
  if not trimmed or trimmed == selected_text then
    return
  end
  
  -- Delete selection and paste trimmed text
  vim.fn.setreg("z", trimmed)
  vim.cmd('normal! gv"zp')
end

return M
