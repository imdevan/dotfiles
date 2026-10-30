local M = {}

function M.js_console_log()
  -- 1. Get the current WORD under the cursor
  local expression = vim.fn.expand("<cWORD>")

  -- 2. Define a pattern to find and keep only valid variable/property characters:
  -- [a-zA-Z0-9_.-] is now [a-zA-Z0-9_.-$]

  -- Pattern for invalid trailing characters (anything NOT in the allowed set at the END)
  local invalid_trailing_chars_pattern = "[^a-zA-Z0-9_.-$]+$"

  -- 3. Trim the expression from the end
  local trimmed_expression = expression:gsub(invalid_trailing_chars_pattern, "")

  -- Pattern for invalid leading characters (anything NOT in the allowed set at the START)
  local invalid_leading_chars_pattern = "^[^a-zA-Z0-9_.-$]+"

  -- Trim the expression from the start
  trimmed_expression = trimmed_expression:gsub(invalid_leading_chars_pattern, "")

  -- 4. Final adjustment for trailing '.' and '?'
  -- This handles cases like 'user.$data.' becoming 'user.$data'
  if trimmed_expression:match("[%.%?]$") then
    -- Remove the last character (the trailing '.' or '?')
    trimmed_expression = trimmed_expression:sub(1, -2)
  end

  -- 5. Fallback/Safety Check
  if trimmed_expression:len() == 0 then
    trimmed_expression = vim.fn.expand("<cword>")
  end

  -- vim.cmd("normal! o" .. "trimmed_expression")
  -- vim.cmd("normal! o" .. trimmed_expression)

  -- 6. Build and insert the console.log statement
  local log_statement = "console.log('" .. trimmed_expression .. ":', " .. trimmed_expression .. ");"
  -- Insert the statement and move cursor for next action
  vim.cmd("normal! }ko" .. log_statement)
  vim.cmd("normal! }ko")
end

return M
