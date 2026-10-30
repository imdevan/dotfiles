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

  -- Use "add" if file has no prior commits, otherwise "update"
  local history = vim.fn.system(string.format("git log --oneline -- %s", vim.fn.shellescape(current_file)))
  local verb = (history == "") and "add" or "update"
  local commit_msg = string.format("%s %s", verb, file_name)
  local commit_cmd = string.format("git commit -m %s", vim.fn.shellescape(commit_msg))
  local commit_result = vim.fn.system(commit_cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to commit: " .. commit_result, vim.log.levels.ERROR)
    return
  end

  vim.notify(string.format("Successfully committed: %s", commit_msg), vim.log.levels.INFO)
end

-- Add current file and commit with message referencing parent dir + filename
-- e.g. utils/github.lua -> "add/update github util"
function M.lazy_nested_commit()
  local current_file = vim.fn.expand("%:p")
  local file_name = vim.fn.expand("%:t:r")
  local parent_dir = vim.fn.expand("%:h:t"):gsub("s$", "")

  if current_file == "" then
    vim.notify("No file is currently open", vim.log.levels.WARN)
    return
  end

  local add_result = vim.fn.system(string.format("git add %s", vim.fn.shellescape(current_file)))
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to add file: " .. add_result, vim.log.levels.ERROR)
    return
  end

  local history = vim.fn.system(string.format("git log --oneline -- %s", vim.fn.shellescape(current_file)))
  local verb = (history == "") and "add" or "update"
  local commit_msg = string.format("%s %s %s", verb, file_name, parent_dir)
  local commit_result = vim.fn.system(string.format("git commit -m %s", vim.fn.shellescape(commit_msg)))

  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to commit: " .. commit_result, vim.log.levels.ERROR)
    return
  end

  vim.notify(string.format("Committed: %s", commit_msg), vim.log.levels.INFO)
end

return M
