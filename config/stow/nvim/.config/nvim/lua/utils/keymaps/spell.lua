local M = {}

local cmd = vim.cmd
local notify = vim.notify

-- Helper function to show spell suggestions (built-in prompt)
function M.show_spell_suggestions()
  -- `z=` opens the built-in suggestions list for the word under cursor
  cmd("normal! z=")
end

-- Navigate to next spelling error and show suggestions
function M.next_spelling_error()
  -- Enable spell checking if not already enabled
  if not vim.wo.spell then
    vim.wo.spell = true
    notify("Spell checking enabled", vim.log.levels.INFO)
  end

  -- Simply execute ]s to jump to next error, then show suggestions
  -- The ]s command will move to the next error or stay put if none found
  cmd("normal! ]s")
  vim.schedule(function()
    cmd("normal z=")
  end)
end

-- Navigate to previous spelling error and show suggestions
function M.prev_spelling_error()
  -- Enable spell checking if not already enabled
  if not vim.wo.spell then
    vim.wo.spell = true
    notify("Spell checking enabled", vim.log.levels.INFO)
  end

  -- Simply execute [s to jump to previous error, then show suggestions
  cmd("normal! [s")

  M.show_spell_suggestions()
end

-- Show suggestions for word under cursor
function M.show_suggestions()
  if not vim.wo.spell then
    vim.wo.spell = true
    notify("Spell checking enabled", vim.log.levels.INFO)
  end
  M.show_spell_suggestions()
end

-- Toggle spell checking
function M.toggle_spell()
  vim.wo.spell = not vim.wo.spell
  local status = vim.wo.spell and "ON" or "OFF"
  notify("Spell checking: " .. status, vim.log.levels.INFO)
end

return M
