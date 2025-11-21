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
vim.keymap.set("n", "<leader>pop", "ggVGp", { desc = "Paste whole page", remap = true })
vim.keymap.set("n", "<leader>poy", "ggVGy", { desc = "Yank whole page", remap = true })

-- Copy / Paste full word
vim.keymap.set("n", "<leader>pc", "bvEy", { desc = "Copy word (from anywhere in word)", remap = true })
vim.keymap.set("n", "<leader>pc", "bvEp", { desc = "Paste word", remap = true })

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

--
-- Open in Editor
-- Helper function
function open_in_editor(editor_cmd)
  local file = vim.fn.expand("%:p")
  if file == "" then
    return
  end

  local line = vim.fn.line(".")
  local dir = vim.fn.fnamemodify(file, ":h")

  vim.fn.jobstart({
    editor_cmd,
    dir,
    "--goto",
    file .. ":" .. line,
  })
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
