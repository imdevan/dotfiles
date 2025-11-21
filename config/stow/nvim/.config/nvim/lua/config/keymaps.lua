-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Custom keymaps
--
-- <leader>P page
-- Full page clear
local log = require("utils.logger").log

vim.keymap.set("n", "<leader>poc", "ggVGd", { desc = "Clear whole page", remap = true })

-- Full page paste
vim.keymap.set("n", "<leader>pop", "ggVGp", { desc = "Paste whole page", remap = true })
vim.keymap.set("n", "<leader>poy", "ggVGy", { desc = "Yank whole page", remap = true })

-- Copy / Paste full word
vim.keymap.set("n", "<leader>py", "bvEy", { desc = "Copy word (from anywhere in word)", remap = true })
vim.keymap.set("n", "<leader>pp", "bvEp", { desc = "Paste word", remap = true })

-- default disable line indention indicators cuz im weird like that
local snacks = require("snacks")
snacks.indent.disable()

vim.keymap.set("n", "<leader>pl", function()
  vim.wo.list = not vim.wo.list
  vim.opt.list = not vim.opt.list
  local current = snacks.indent.enabled

  if current then
    snacks.indent.disable()
  else
    snacks.indent.enable()
  end
end, { desc = "Toggle indent lines", remap = true })

-- https://github.com/folke/todo-comments.nvim
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
end, { desc = "Next error/warning todo comment" })

-- Open in Editor
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
local function open_in_editor(editor_cmd, opts)
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
-- Open in Vscode
vim.keymap.set("n", "<leader>ov", function()
  open_in_editor("code")
end, { desc = "Open file and parent folder in VS Code" })

-- Open in Cursor
vim.keymap.set("n", "<leader>oc", function()
  open_in_editor("cursor")
end, { desc = "Open in Cursor at line" })

-- Open in Kiro
vim.keymap.set("n", "<leader>ok", function()
  open_in_editor("kiro")
end, { desc = "Open in Kiro at line" })
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Custom keymaps
--
-- <leader>P page
-- Full page clear
vim.keymap.set("n", "<leader>poc", "ggVGd", { desc = "Clear whole page", remap = true })
-- Full page paste
vim.keymap.set("n", "<leader>pop", "ggVGp", { desc = "Clear whole page", remap = true })
vim.keymap.set("n", "<leader>poy", "ggVGy", { desc = "Clear whole page", remap = true })
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Custom keymaps
--
-- <leader>P page
-- Full page clear
vim.keymap.set("n", "<leader>poc", "ggVGd", { desc = "Clear whole page", remap = true })
-- Full page paste
vim.keymap.set("n", "<leader>pop", "ggVGp", { desc = "Clear whole page", remap = true })
vim.keymap.set("n", "<leader>poy", "ggVGy", { desc = "Clear whole page", remap = true })
