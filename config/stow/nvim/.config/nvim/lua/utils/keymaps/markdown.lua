local M = {}

local api = vim.api
local fn = vim.fn
local notify = vim.notify

-- Copy markdown headers by level
function M.copy_headers_by_level(level)
  -- Validate level is between 1 and 6
  if level < 1 or level > 6 then
    notify("Header level must be between 1 and 6", vim.log.levels.ERROR)
    return
  end

  -- Build the header pattern (e.g., "^## " for level 2)
  local hashes = string.rep("#", level)
  local pattern = "^" .. hashes .. " "

  -- Clear register a
  fn.setreg("a", "")

  -- Save cursor position
  local save_pos = fn.getpos(".")

  -- Search for headers and collect text after them
  vim.cmd(string.format([[g/%s/s/%s\(.*\)/\=setreg('A', submatch(1)."\n")/n]], pattern, pattern))

  -- Restore cursor position
  fn.setpos(".", save_pos)

  -- Paste the collected content
  vim.cmd('normal! "ap')

  notify(string.format("Copied all level %d headers to cursor", level), vim.log.levels.INFO)
end

-- Convert line/selection into markdown header (levels 0-9)
function M.convert_lines_to_header(level, start_line, end_line)
  if level < 0 or level > 9 then
    notify("Header level must be between 0 and 9", vim.log.levels.ERROR)
    return
  end

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local bufnr = 0
  local lines = api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
  local hashes = level > 0 and string.rep("#", level) or nil
  local single_empty_line = (#lines == 1 and (lines[1] == "" or lines[1]:match("^%s*$")))

  for idx, line in ipairs(lines) do
    local indent = line:match("^%s*") or ""
    local rest = line:sub(#indent + 1)
    local title = rest:gsub("^#+%s*", ""):gsub("^%s+", ""):gsub("%s+$", "")

    if level == 0 then
      -- Strip any existing markdown header prefix.
      lines[idx] = title == "" and indent or (indent .. title)
    else
      if title == "" then
        -- For empty lines, add header markers
        if level >= 1 then
          -- Add space after header markers for level >= 1
          lines[idx] = indent .. hashes .. " "
        else
          lines[idx] = indent .. hashes
        end
      else
        lines[idx] = indent .. hashes .. " " .. title
      end
    end
  end

  api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, lines)

  -- If it was a single empty line, enter insert mode at the end
  if single_empty_line and level > 0 then
    vim.cmd("startinsert!")
  end
end

-- Convert current line to header
function M.convert_line_to_header(level)
  local api = vim.api
  local line = api.nvim_win_get_cursor(0)[1]
  M.convert_lines_to_header(level, line, line)
end

-- Convert visual selection to header
function M.convert_selection_to_header(level)
  local fn = vim.fn
  local start_line = fn.line("v")
  local end_line = fn.line(".")
  M.convert_lines_to_header(level, start_line, end_line)
end

-- Toggle render markdown
local render_markdown_enabled = true

function M.toggle_render_markdown()
  if render_markdown_enabled then
    vim.cmd("RenderMarkdown disable")
  else
    vim.cmd("RenderMarkdown enable")
  end

  render_markdown_enabled = not render_markdown_enabled
end

-- Toggle boldness
function M.toggle_bold()
  local mode = vim.fn.mode()

  if mode == "v" or mode == "V" or mode == "\22" then
    -- Visual mode - use visual function
    M.toggle_bold_v()
  else
    -- Normal mode - use normal function
    M.toggle_bold_n()
  end
end

-- Toggle boldness in normal mode (current word)
function M.toggle_bold_n()
  local bufnr = 0
  local cursor = api.nvim_win_get_cursor(0)
  local line_num = cursor[1]
  local col_num = cursor[2] + 1 -- Convert to 1-based indexing
  local line = api.nvim_buf_get_lines(bufnr, line_num - 1, line_num, false)[1]

  if not line then
    return
  end

  -- Find word boundaries around cursor
  local before_cursor = line:sub(1, col_num - 1)
  local after_cursor = line:sub(col_num)
  
  -- Find start of word (go backwards from cursor)
  local word_start = col_num
  for i = col_num - 1, 1, -1 do
    local char = line:sub(i, i)
    if char:match("%W") then
      word_start = i + 1
      break
    end
    if i == 1 then
      word_start = 1
    end
  end
  
  -- Find end of word (go forwards from cursor)
  local word_end = col_num
  for i = col_num, #line do
    local char = line:sub(i, i)
    if char:match("%W") then
      word_end = i - 1
      break
    end
    if i == #line then
      word_end = #line
    end
  end
  
  -- Extract the word
  local word = line:sub(word_start, word_end)
  
  if word == "" then
    return
  end
  
  local new_line
  local new_cursor_pos
  
  -- Check if word is already bold
  local bold_start = word_start - 2
  local bold_end = word_end + 2
  
  if bold_start >= 1 and bold_end <= #line and 
     line:sub(bold_start, bold_start + 1) == "**" and 
     line:sub(bold_end - 1, bold_end) == "**" then
    -- Remove bold formatting
    new_line = line:sub(1, bold_start - 1) .. word .. line:sub(bold_end + 1)
    new_cursor_pos = col_num - 2 -- Adjust cursor position
  else
    -- Add bold formatting
    new_line = line:sub(1, word_start - 1) .. "**" .. word .. "**" .. line:sub(word_end + 1)
    new_cursor_pos = col_num + 2 -- Adjust cursor position
  end
  
  -- Set the new line
  api.nvim_buf_set_lines(bufnr, line_num - 1, line_num, false, { new_line })
  
  -- Update cursor position
  api.nvim_win_set_cursor(0, { line_num, new_cursor_pos - 1 }) -- Convert back to 0-based
end

-- Toggle boldness in visual mode (selected text)
function M.toggle_bold_v()
  local bufnr = 0
  
  -- Get visual selection range
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]
  
  -- Handle single line selection
  if start_line == end_line then
    local line = api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]
    if not line then
      return
    end
    
    -- Get selected text
    local selected_text = line:sub(start_col, end_col)
    
    local new_line
    local cursor_adjustment = 0
    
    -- Check if selection is already bold
    local bold_start = start_col - 2
    local bold_end = end_col + 2
    
    if bold_start >= 1 and bold_end <= #line and 
       line:sub(bold_start, bold_start + 1) == "**" and 
       line:sub(bold_end - 1, bold_end) == "**" then
      -- Remove bold formatting
      new_line = line:sub(1, bold_start - 1) .. selected_text .. line:sub(bold_end + 1)
      cursor_adjustment = -2
    else
      -- Add bold formatting
      new_line = line:sub(1, start_col - 1) .. "**" .. selected_text .. "**" .. line:sub(end_col + 1)
      cursor_adjustment = 2
    end
    
    -- Set the new line
    api.nvim_buf_set_lines(bufnr, start_line - 1, start_line, false, { new_line })
    
  else
    -- Handle multi-line selection
    local lines = api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
    
    -- Get the selected text across multiple lines
    local selected_lines = {}
    for i, line in ipairs(lines) do
      if i == 1 and i == #lines then
        -- Single line case (shouldn't happen here, but just in case)
        selected_lines[i] = line:sub(start_col, end_col)
      elseif i == 1 then
        -- First line
        selected_lines[i] = line:sub(start_col)
      elseif i == #lines then
        -- Last line
        selected_lines[i] = line:sub(1, end_col)
      else
        -- Middle lines
        selected_lines[i] = line
      end
    end
    
    local selected_text = table.concat(selected_lines, "\n")
    
    -- Check if the selection is already bold by looking at the boundaries
    local first_line = lines[1]
    local last_line = lines[#lines]
    
    local is_bold = false
    if start_col >= 3 and first_line:sub(start_col - 2, start_col - 1) == "**" and
       end_col <= #last_line - 2 and last_line:sub(end_col + 1, end_col + 2) == "**" then
      is_bold = true
    end
    
    local new_lines = {}
    
    if is_bold then
      -- Remove bold formatting
      for i, line in ipairs(lines) do
        if i == 1 and i == #lines then
          -- Single line
          new_lines[i] = line:sub(1, start_col - 3) .. selected_text .. line:sub(end_col + 3)
        elseif i == 1 then
          -- First line - remove ** from the beginning
          new_lines[i] = line:sub(1, start_col - 3) .. line:sub(start_col)
        elseif i == #lines then
          -- Last line - remove ** from the end
          new_lines[i] = line:sub(1, end_col) .. line:sub(end_col + 3)
        else
          -- Middle lines remain unchanged
          new_lines[i] = line
        end
      end
    else
      -- Add bold formatting
      for i, line in ipairs(lines) do
        if i == 1 and i == #lines then
          -- Single line
          new_lines[i] = line:sub(1, start_col - 1) .. "**" .. selected_text .. "**" .. line:sub(end_col + 1)
        elseif i == 1 then
          -- First line - add ** at the beginning of selection
          new_lines[i] = line:sub(1, start_col - 1) .. "**" .. line:sub(start_col)
        elseif i == #lines then
          -- Last line - add ** at the end of selection
          new_lines[i] = line:sub(1, end_col) .. "**" .. line:sub(end_col + 1)
        else
          -- Middle lines remain unchanged
          new_lines[i] = line
        end
      end
    end
    
    -- Set the new lines
    api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, new_lines)
  end
  
  -- Exit visual mode
  api.nvim_feedkeys(api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

-- Toggle checkbox for a single line
function M.toggle_checkbox_single_line()
  local bufnr = 0
  local cursor = api.nvim_win_get_cursor(0)
  local line_num = cursor[1]
  local line = api.nvim_buf_get_lines(bufnr, line_num - 1, line_num, false)[1]

  if not line then
    return
  end

  local new_line
  local single_blank_line = false

  -- Handle blank line
  if line == "" or line:match("^%s*$") then
    local indent = line:match("^%s*") or ""
    new_line = indent .. "- [ ] "
    single_blank_line = true
  else
    -- Capture leading whitespace
    local indent = line:match("^%s*") or ""
    local rest = line:sub(#indent + 1)

    local new_rest
    -- Check if there's a checked checkbox
    if rest:match("^%- %[x%]") then
      -- Toggle from checked to unchecked
      new_rest = rest:gsub("^%- %[x%]", "- [ ]")
    -- Check if there's an unchecked checkbox
    elseif rest:match("^%- %[ %]") then
      -- Toggle from unchecked to checked
      new_rest = rest:gsub("^%- %[ %]", "- [x]")
    else
      -- No checkbox found, add unchecked checkbox
      -- Remove leading "- " if it exists (plain list item)
      local content = rest:gsub("^%-%s*", "")
      new_rest = "- [ ] " .. content
    end

    -- Reconstruct the line
    new_line = indent .. new_rest
  end

  -- Set the new line
  api.nvim_buf_set_lines(bufnr, line_num - 1, line_num, false, { new_line })

  -- If it was a single blank line, enter insert mode at the end
  if single_blank_line then
    vim.cmd("startinsert!")
  end
end

-- Toggle checkbox for multiple lines (visual selection)
function M.toggle_checkbox_multi_line()
  local bufnr = 0
  
  -- Get visual selection range
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  
  -- Ensure start_line is always less than or equal to end_line
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  -- Debug: validate line numbers
  local total_lines = api.nvim_buf_line_count(bufnr)
  if start_line < 1 or end_line > total_lines then
    notify("Invalid line range: " .. start_line .. "-" .. end_line .. " (total: " .. total_lines .. ")", vim.log.levels.ERROR)
    return
  end

  -- Get all lines in the selection at once
  local lines = api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
  local new_lines = {}

  -- First pass: determine what action to take based on existing checkboxes
  local has_checked = false
  local has_unchecked = false
  local has_no_checkbox = false

  for _, line in ipairs(lines) do
    if line and line ~= "" and not line:match("^%s*$") then
      local indent = line:match("^%s*") or ""
      local rest = line:sub(#indent + 1)
      
      if rest:match("^%- %[x%]") then
        has_checked = true
      elseif rest:match("^%- %[ %]") then
        has_unchecked = true
      else
        has_no_checkbox = true
      end
    end
  end

  -- Determine action based on what we found
  local action
  if has_no_checkbox then
    -- If any lines don't have checkboxes, add checkboxes to all
    action = "add"
  elseif has_checked and not has_unchecked then
    -- If all checkboxes are checked, uncheck them
    action = "uncheck"
  elseif has_unchecked and not has_checked then
    -- If all checkboxes are unchecked, check them
    action = "check"
  else
    -- Mixed state: check all unchecked ones
    action = "check"
  end

  -- Process each line based on the determined action
  for idx, line in ipairs(lines) do
    if not line then
      new_lines[idx] = line
      goto continue
    end

    local new_line
    -- Handle blank line - always keep empty lines as-is in multi-line mode
    if line == "" or line:match("^%s*$") then
      new_line = line -- Keep blank lines unchanged
    else
      -- Capture leading whitespace
      local indent = line:match("^%s*") or ""
      local rest = line:sub(#indent + 1)

      local new_rest
      if action == "add" then
        -- Add checkbox to lines that don't have one
        if rest:match("^%- %[[ x]%]") then
          new_rest = rest -- Already has checkbox
        else
          -- Handle different line types
          if rest:match("^%d+%)") then
            -- Numbered list item (e.g., "1) Item")
            new_rest = "- [ ] " .. rest
          elseif rest:match("^%-") then
            -- Plain list item (e.g., "- Item")
            local content = rest:gsub("^%-%s*", "")
            new_rest = "- [ ] " .. content
          elseif rest:match("^#+") then
            -- Header (e.g., "## Title")
            new_rest = "- [ ] " .. rest
          else
            -- Regular text
            new_rest = "- [ ] " .. rest
          end
        end
      elseif action == "check" then
        -- Check unchecked boxes, add checkbox to lines without one
        if rest:match("^%- %[ %]") then
          new_rest = rest:gsub("^%- %[ %]", "- [x]")
        elseif rest:match("^%- %[x%]") then
          new_rest = rest -- Already checked
        else
          -- No checkbox, add checked one
          if rest:match("^%d+%)") then
            -- Numbered list item
            new_rest = "- [x] " .. rest
          elseif rest:match("^%-") then
            -- Plain list item
            local content = rest:gsub("^%-%s*", "")
            new_rest = "- [x] " .. content
          elseif rest:match("^#+") then
            -- Header
            new_rest = "- [x] " .. rest
          else
            -- Regular text
            new_rest = "- [x] " .. rest
          end
        end
      elseif action == "uncheck" then
        -- Uncheck checked boxes
        if rest:match("^%- %[x%]") then
          new_rest = rest:gsub("^%- %[x%]", "- [ ]")
        elseif rest:match("^%- %[ %]") then
          new_rest = rest -- Already unchecked
        else
          -- No checkbox, add unchecked one
          if rest:match("^%d+%)") then
            -- Numbered list item
            new_rest = "- [ ] " .. rest
          elseif rest:match("^%-") then
            -- Plain list item
            local content = rest:gsub("^%-%s*", "")
            new_rest = "- [ ] " .. content
          elseif rest:match("^#+") then
            -- Header
            new_rest = "- [ ] " .. rest
          else
            -- Regular text
            new_rest = "- [ ] " .. rest
          end
        end
      end

      -- Reconstruct the line
      new_line = indent .. new_rest
    end

    new_lines[idx] = new_line

    ::continue::
  end

  -- Validate indices before setting lines
  local start_idx = start_line - 1
  local end_idx = end_line
  
  if start_idx < 0 or end_idx < start_idx then
    notify("Invalid buffer indices: start=" .. start_idx .. ", end=" .. end_idx, vim.log.levels.ERROR)
    return
  end

  -- Set all lines at once
  api.nvim_buf_set_lines(bufnr, start_idx, end_idx, false, new_lines)

  -- Force buffer update and redraw to prevent timing issues
  vim.cmd("silent! write")
  vim.cmd("redraw!")

  -- Exit visual mode
  api.nvim_feedkeys(api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

-- Main toggle checkbox function that determines mode and calls appropriate function
function M.toggle_checkbox()
  local mode = vim.fn.mode()

  if mode == "v" or mode == "V" or mode == "\22" then
    -- Visual mode - use multi-line function
    M.toggle_checkbox_multi_line()
  else
    -- Normal mode - use single-line function
    M.toggle_checkbox_single_line()
  end
end

-- Insert front matter at the top of the file
function M.insert_front_matter()
  local bufnr = 0

  -- Go to the top of the file
  api.nvim_win_set_cursor(0, { 1, 0 })

  -- Insert the front matter template
  local front_matter = {
    "---",
    "",
    "---",
  }

  -- Insert at the beginning of the file
  api.nvim_buf_set_lines(bufnr, 0, 0, false, front_matter)

  -- Position cursor in the middle (line 2, which is the empty line between the dashes)
  api.nvim_win_set_cursor(0, { 2, 0 })

  -- Enter insert mode
  vim.cmd("startinsert!")
end

return M

