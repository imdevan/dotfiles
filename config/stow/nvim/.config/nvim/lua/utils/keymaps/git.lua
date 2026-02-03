local M = {}

-- Reset git hunk under cursor
function M.reset_hunk()
  require("gitsigns").reset_hunk()
end

-- Add current file to git history
-- Commit with message "update <file_name>" ommiting file extensions
function M.lazy_commit()
  local current_file = vim.fn.expand("%:p")
  local file_name = vim.fn.expand("%:t:r") -- Get filename without extension
  
  if current_file == "" then
    vim.notify("No file is currently open", vim.log.levels.WARN)
    return
  end
  
  -- Add the current file to git
  local add_cmd = string.format("git add %s", vim.fn.shellescape(current_file))
  local add_result = vim.fn.system(add_cmd)
  
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to add file to git: " .. add_result, vim.log.levels.ERROR)
    return
  end
  
  -- Commit with the lazy message
  local commit_msg = string.format("update %s", file_name)
  local commit_cmd = string.format("git commit -m %s", vim.fn.shellescape(commit_msg))
  local commit_result = vim.fn.system(commit_cmd)
  
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to commit: " .. commit_result, vim.log.levels.ERROR)
    return
  end
  
  vim.notify(string.format("Successfully committed: %s", commit_msg), vim.log.levels.INFO)
end

return M
