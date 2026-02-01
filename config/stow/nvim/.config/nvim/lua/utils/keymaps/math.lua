local M = {}

local api = vim.api
local fn = vim.fn
local cmd = vim.cmd
local notify = vim.notify

-- Evaluate math expression from selected text
function M.evaluate_math_expression()
  -- Save current selection to register m
  cmd('normal! "my')
  local selected_text = fn.getreg("m")

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
  -- Save current selection to register m
  cmd('normal! "my')
  local selected_text = fn.getreg("m")

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

  -- Replace selection with result using a more reliable method
  -- Split processed text into lines for proper handling
  local processed_lines = vim.split(processed_text, "\n", { plain = true })
  
  -- Use vim.paste to replace the selection
  -- First, reselect the visual selection
  cmd('normal! gv')
  
  -- Use vim.paste which handles multi-line text correctly
  vim.paste(processed_lines, -1)

  notify("Applied " .. (operator == "+" and expr or operator .. value_str) .. " to all numbers", vim.log.levels.INFO)
end

-- Evaluate expression and insert result (normal mode)
function M.evaluate_and_insert()
  local api = vim.api
  local keys = api.nvim_replace_termcodes("i<C-r>=", true, false, true)
  api.nvim_feedkeys(keys, "n", false)
end

return M