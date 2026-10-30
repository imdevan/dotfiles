-- Paragraph navigation utilities

local M = {}

function M.jump_up()
  local current_line = vim.fn.line(".")
  local prev_line_num = current_line - 1
  
  -- if line above cursor is blank line:
  --     go to next non-blank line
  if prev_line_num < 1 or vim.fn.getline(prev_line_num):match("^%s*$") ~= nil then
    -- Move up to find next non-blank line
    while prev_line_num >= 1 and vim.fn.getline(prev_line_num):match("^%s*$") ~= nil do
      prev_line_num = prev_line_num - 1
    end
    if prev_line_num >= 1 then
      vim.fn.cursor(prev_line_num, 1)
      vim.cmd("normal! ^")
    end
  else
    -- if line above cursor is not blank
    --   go to the begining of the paragraph (non-blank line followed by blank line)
    while prev_line_num >= 1 do
      local line_content = vim.fn.getline(prev_line_num)
      local prev_prev_line_num = prev_line_num - 1
      local prev_prev_is_blank = prev_prev_line_num < 1 or vim.fn.getline(prev_prev_line_num):match("^%s*$") ~= nil
      
      -- Found beginning of paragraph (non-blank line preceded by blank line or start of file)
      if line_content:match("^%s*$") == nil and prev_prev_is_blank then
        vim.fn.cursor(prev_line_num, 1)
        vim.cmd("normal! ^")
        return
      end
      prev_line_num = prev_line_num - 1
    end
    -- If we reach here, go to line 1
    vim.fn.cursor(1, 1)
    vim.cmd("normal! ^")
  end
end

function M.jump_down()
  local current_line = vim.fn.line(".")
  local next_line_num = current_line + 1
  local last_line = vim.fn.line("$")
  
  -- if line below cursor is blank line:
  --     go to next non-blank line
  if next_line_num > last_line or vim.fn.getline(next_line_num):match("^%s*$") ~= nil then
    -- Move down to find next non-blank line
    while next_line_num <= last_line and vim.fn.getline(next_line_num):match("^%s*$") ~= nil do
      next_line_num = next_line_num + 1
    end
    if next_line_num <= last_line then
      vim.fn.cursor(next_line_num, 1)
      vim.cmd("normal! ^")
    end
  else
    -- if line below cursor is not blank
    --   go to the end of the paragraph (non-blank line followed by blank line)
    while next_line_num <= last_line do
      local line_content = vim.fn.getline(next_line_num)
      local next_next_line_num = next_line_num + 1
      local next_next_is_blank = next_next_line_num > last_line or vim.fn.getline(next_next_line_num):match("^%s*$") ~= nil
      
      -- Found end of paragraph (non-blank line followed by blank line or end of file)
      if line_content:match("^%s*$") == nil and next_next_is_blank then
        vim.fn.cursor(next_line_num, 1)
        vim.cmd("normal! ^")
        return
      end
      next_line_num = next_line_num + 1
    end
    -- If we reach here, go to last line
    vim.fn.cursor(last_line, 1)
    vim.cmd("normal! ^")
  end
end

-- Jump up: go to first non-blank line, then to start of paragraph
function M.jump_to_paragraph_up()
  -- Move to first non-blank character on current line
  vim.cmd("normal! ^")

  -- Get current position info
  local current_line = vim.fn.line(".")
  local prev_line_num = current_line - 1
  local next_line_num = current_line + 1
  local last_line = vim.fn.line("$")

  -- Check surrounding lines
  local prev_is_blank = prev_line_num < 1 or vim.fn.getline(prev_line_num):match("^%s*$") ~= nil
  local next_is_blank = next_line_num > last_line or vim.fn.getline(next_line_num):match("^%s*$") ~= nil

  -- If it's a single-line paragraph, just go to previous non-blank line
  if prev_is_blank and next_is_blank then
    vim.cmd("normal! {")
    vim.cmd("normal! ^")
    return
  end

  -- If at start of paragraph, jump to previous paragraph first
  if prev_is_blank and not next_is_blank then
    vim.cmd("normal! {")
  end

  -- Move to paragraph start
  vim.cmd("normal! {")

  -- Move to first non-blank line
  if vim.fn.getline("."):match("^%s*$") then
    vim.cmd("normal! j")
  end
end

-- Jump down: go to first non-blank line, then to end of paragraph
function M.jump_to_paragraph_down()
  -- Move to first non-blank character on current line
  vim.cmd("normal! ^")

  -- Get current position info
  local current_line = vim.fn.line(".")
  local prev_line_num = current_line - 1
  local next_line_num = current_line + 1
  local last_line = vim.fn.line("$")

  -- Check surrounding lines
  local prev_is_blank = prev_line_num < 1 or vim.fn.getline(prev_line_num):match("^%s*$") ~= nil
  local next_is_blank = next_line_num > last_line or vim.fn.getline(next_line_num):match("^%s*$") ~= nil

  -- If it's a single-line paragraph, just go to next non-blank line
  if prev_is_blank and next_is_blank then
    vim.cmd("normal! }")
    vim.cmd("normal! ^")
    return
  end

  -- If at end of paragraph, jump to next paragraph first
  if next_is_blank and not prev_is_blank then
    vim.cmd("normal! }")
  end

  -- Move to paragraph end
  vim.cmd("normal! }")

  -- Move to last non-blank line
  if vim.fn.getline("."):match("^%s*$") then
    vim.cmd("normal! k")
  end
end

return M
