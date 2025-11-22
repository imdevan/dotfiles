-- Keymaps are automatically loaded on the VeryLazy event
--
-- Default keymaps
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- Docs
-- http://www.lazyvim.org/keymaps
--
-- Custom keymaps

local log = require("utils.logger").log
local open_in_editor = require("utils.open_in_editor").open_in_editor
local open_in_editor = require("utils.open_in_editor").open_in_editor
local js_console_log = require("utils.js_console_log").js_console_log

-- Clear whole page
vim.keymap.set("n", "<leader>poc", "ggVGd", { desc = "Clear whole page", remap = true })

-- Full page paste
vim.keymap.set("n", "<leader>pop", 'ggVG"0p', { desc = "Paste whole page", remap = true })
vim.keymap.set("n", "<leader>poy", "ggVGy", { desc = "Yank whole page", remap = true })

-- Copy / Paste full word
vim.keymap.set("n", "<leader>py", "bvEy", { desc = "Copy word (from anywhere in word)", remap = true })
vim.keymap.set("n", "<leader>pp", "bvEp", { desc = "Paste word", remap = true })

-- Default disable line indention indicators cuz im weird like that
local snacks = require("snacks")
snacks.indent.disable()

-- Toggle indent lines
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

-- Todo comments
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

-- Glance
-- https://github.com/dnlhc/glance.nvim
-- TODO: move to glance.lua
vim.keymap.set("n", "gR", "<CMD>Glance references<CR>")
vim.keymap.set("n", "gY", "<CMD>Glance type_definitions<CR>")
vim.keymap.set("n", "gM", "<CMD>Glance implementations<CR>")

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

-- Logger
vim.keymap.set("n", "<leader>pcl", js_console_log, { desc = "[C]onsole [L]og variable" })
