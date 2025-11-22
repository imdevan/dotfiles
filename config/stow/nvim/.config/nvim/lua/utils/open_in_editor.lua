-- Open in Editor

-- export Module
local M = {}

-- Helper functions
local function exists(path)
  if not path or path == "" then
    return false
  end
  local stat = vim.loop.fs_stat(path)
  return stat ~= nil
end

-- Walk upward and return the highest directory containing a .gitignore.
-- Returns nil if none found.
local function find_top_gitignore_dir(start_dir)
  if not start_dir or start_dir == "" then
    return nil
  end

  local current = start_dir
  local found = nil
  local visited = {}

  while true do
    if visited[current] then
      break
    end
    visited[current] = true

    local candidate = current .. "/.gitignore"
    if exists(candidate) then
      found = current
    end

    local parent = vim.fn.fnamemodify(current, ":h")

    if parent == current or parent == "" then
      break
    end

    current = parent
  end

  return found
end

-- Optional: fallback to git top-level
local function git_toplevel(dir)
  local handle = io.popen("git -C " .. vim.fn.shellescape(dir) .. " rev-parse --show-toplevel 2>/dev/null")
  if not handle then
    return nil
  end
  local out = handle:read("*a")
  handle:close()
  if out and out:match("%S") then
    return out:gsub("%s+$", "")
  end
  return nil
end

-- editor_cmd: string or table
-- opts.use_git_fallback: try git top-level when no .gitignore found
-- opts.args: optional extra args (table)
function M.open_in_editor(editor_cmd, opts)
  opts = opts or {}
  local use_git_fallback = opts.use_git_fallback == true

  local file = vim.fn.expand("%:p")
  if not file or file == "" then
    return
  end

  local line = vim.fn.line(".")
  local start_dir = vim.fn.fnamemodify(file, ":h")

  local root = find_top_gitignore_dir(start_dir)

  if not root and use_git_fallback then
    root = git_toplevel(start_dir)
  end

  root = root or start_dir

  -- Build args for jobstart
  local args = {}

  if type(editor_cmd) == "table" then
    for _, v in ipairs(editor_cmd) do
      args[#args + 1] = v
    end
  else
    args[1] = editor_cmd
  end

  if opts.args and type(opts.args) == "table" then
    for _, v in ipairs(opts.args) do
      args[#args + 1] = v
    end
  end

  args[#args + 1] = root
  args[#args + 1] = "--goto"
  args[#args + 1] = file .. ":" .. tostring(line)

  vim.fn.jobstart(args, { detach = true })
end

return M
