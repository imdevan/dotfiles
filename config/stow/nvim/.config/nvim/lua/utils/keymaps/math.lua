local M = {}

local api = vim.api
local fn = vim.fn
local cmd = vim.cmd
local notify = vim.notify

-- Evaluate math expression from selected text
function M.evaluate_math_expression()
  -- Save current selection to register
  cmd('normal! "vy')
  local selected_text = fn.getreg("v")

  if selected_text == "" then
    notify("No selection", vim.log.levels.WARN)
    return
  end

  -- Trim whitespace and newlines
  selected_text = selected_text:gsub("^%s+", ""):gsub("%s+$", ""):gsub("\n", "")

  -- Evaluate using Lua with math environment
  local success, result = pcall(function()
    local math_env = setmetatable({}, { __index = math })
    math_env.pi = math.pi
    math_env.e = math.exp(1)
    local func = load("return " .. selected_text, "math_eval", "t", math_env)
    if func then
      return func()
    end
    return nil
  end)

  if success and result ~= nil then
    local result_str = tostring(result)
    -- Replace selection with result
    cmd("normal! gvc" .. result_str)
    notify("Evaluated: " .. selected_text .. " = " .. result_str, vim.log.levels.INFO)
  else
    notify("Failed to evaluate: " .. selected_text, vim.log.levels.ERROR)
  end
end

-- Apply math expression to all numbers in selection
function M.apply_math_to_numbers()
  -- Save current selection to register
  cmd('normal! "vy')
  local selected_text = fn.getreg("v")

  if selected_text == "" then
    notify("No selection", vim.log.levels.WARN)
    return
  end

  -- Prompt for math expression
  local expr = fn.input("Math expression (e.g., 16, +16, *2, -5, /3): ")
  if expr == "" then
    notify("No expression provided", vim.log.levels.WARN)
    return
  end

  -- Determine operator and value
  -- If expression starts with operator, use it; otherwise default to addition
  local operator, value_str
  if expr:match("^[+%-*/]") then
    operator = expr:sub(1, 1)
    value_str = expr:sub(2)
  else
    -- Default to addition if just a number is provided
    operator = "+"
    value_str = expr
  end

  local success, value = pcall(function()
    return tonumber(value_str)
  end)

  if not success or not value then
    notify("Invalid number: " .. value_str, vim.log.levels.ERROR)
    return
  end

  -- Function to apply math operation to a number
  local function apply_operation(num_str)
    local num = tonumber(num_str)
    if not num then
      return num_str -- Return original if not a number
    end

    local result
    if operator == "+" then
      result = num + value
    elseif operator == "-" then
      result = num - value
    elseif operator == "*" then
      result = num * value
    elseif operator == "/" then
      if value == 0 then
        notify("Division by zero", vim.log.levels.ERROR)
        return num_str
      end
      result = num / value
    else
      return num_str
    end

    -- Preserve format: if original was integer and result is whole, return integer
    -- Otherwise preserve decimal precision
    if num_str:match("^%-?%d+$") and result == math.floor(result) then
      -- Was integer, result is whole number
      return tostring(math.floor(result))
    elseif num_str:match("%.") then
      -- Had decimal point, try to preserve similar precision
      local decimals = num_str:match("%.(%d+)")
      local precision = decimals and #decimals or 2
      return string.format("%." .. precision .. "f", result)
    else
      -- Integer input but fractional result
      return tostring(result)
    end
  end

  -- Replace all numbers in the selected text
  -- Pattern: matches numbers (including negative and decimal)
  local processed_text = selected_text:gsub("([%-%+]?%d+%.?%d*)", apply_operation)

  -- Check if text was actually modified
  if processed_text == selected_text then
    notify("No numbers found in selection", vim.log.levels.WARN)
    return
  end

  -- Get visual selection boundaries
  local start_pos = api.nvim_buf_get_mark(0, "<")
  local end_pos = api.nvim_buf_get_mark(0, ">")
  local start_line, start_col = start_pos[1] - 1, start_pos[2] -- Convert to 0-indexed
  local end_line, end_col = end_pos[1] - 1, end_pos[2]

  -- Split processed text into lines
  local processed_lines = vim.split(processed_text, "\n", { plain = true })

  -- Get current lines
  local lines = api.nvim_buf_get_lines(0, start_line, end_line + 1, false)

  if #lines == 0 then
    notify("No lines to process", vim.log.levels.WARN)
    return
  end

  -- Handle replacement based on selection type
  if start_line == end_line then
    -- Single line: replace portion between start_col and end_col
    local line = lines[1]
    -- start_col is 0-indexed, Lua strings are 1-indexed
    -- before: characters 1 to start_col (inclusive)
    local before = start_col > 0 and line:sub(1, start_col) or ""
    -- after: characters after end_col (end_col is inclusive, so +2 for next char)
    local after = line:sub(end_col + 2)
    lines[1] = before .. processed_lines[1] .. after
  else
    -- Multi-line: replace first line from start_col, middle lines entirely, last line up to end_col
    if #processed_lines > 0 then
      -- First line
      local first_line = lines[1]
      local before = start_col > 0 and first_line:sub(1, start_col) or ""
      lines[1] = before .. processed_lines[1]
      table.remove(processed_lines, 1)

      -- Middle lines
      for i = 2, #lines - 1 do
        if #processed_lines > 0 then
          lines[i] = processed_lines[1]
          table.remove(processed_lines, 1)
        end
      end

      -- Last line
      if #processed_lines > 0 and #lines > 1 then
        local last_line = lines[#lines]
        local after = last_line:sub(end_col + 2)
        lines[#lines] = processed_lines[1] .. after
      end
    end
  end

  -- Replace the lines in the buffer
  api.nvim_buf_set_lines(0, start_line, end_line + 1, false, lines)

  notify("Applied " .. (operator == "+" and expr or operator .. value_str) .. " to all numbers", vim.log.levels.INFO)
end

-- Evaluate expression and insert result (normal mode)
function M.evaluate_and_insert()
  local api = vim.api
  local keys = api.nvim_replace_termcodes("i<C-r>=", true, false, true)
  api.nvim_feedkeys(keys, "n", false)
end

return M
