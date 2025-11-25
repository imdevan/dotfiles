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

-- -- Navigation
-- vim.keymap.set("n", "<C-h>", "<leader>wh", { desc = "window right", remap = true })
-- vim.keymap.set("n", "<C-l>", "<leader>wl", { desc = "window left", remap = true })

-- Clear whole page
vim.keymap.set("n", "<leader>poc", "ggVGd", { desc = "Clear whole page", remap = true })

-- Full page paste
vim.keymap.set("n", "<leader>pop", 'ggVG"0p', { desc = "Paste whole page", remap = true })
vim.keymap.set("n", "<leader>poy", "ggVGy", { desc = "Yank whole page", remap = true })

-- Copy / Paste full word
vim.keymap.set("n", "<leader>py", "bvEy", { desc = "Copy word (from anywhere in word)", remap = true })
vim.keymap.set("n", "<leader>pY", "BvEy", { desc = "Copy Full word (from anywhere in word)", remap = true })
vim.keymap.set("n", "<leader>pp", "bvEp", { desc = "Paste word", remap = true })
vim.keymap.set("n", "<leader>pP", "BvEp", { desc = "Paste Full word", remap = true })

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

-- Select all
vim.keymap.set("n", "<M-a>", "ggVG")

-- Save
vim.keymap.set("n", "<M-s>", "<CMD>write<CR>", { silent = true })
vim.keymap.set("i", "<M-s>", "<CMD>write<CR>", { silent = true })

-- Quit
vim.keymap.set("n", "<M-q>", "<CMD>quit<CR>", { silent = true })
vim.keymap.set("n", "<M-Q>", "<CMD>Quit<CR>", { silent = true })

-- Reload file
vim.keymap.set("n", "<M-r>", "<CMD>e!<CR>", {
  desc = "Reload file from disk",
  remap = true,
})

-- Case (toggle)
vim.keymap.set("i", "<leader>pcc", "~", { desc = "Toggle case" })

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

-- Logger
-- TODO: find a better logging solution similar to turbo console_log
vim.keymap.set("n", "<leader>pcl", js_console_log, { desc = "[C]onsole [L]og variable" })

local Snacks = require("snacks")

-- Toggle snacks ignored and hidden
vim.keymap.set("n", "<leader>ti", function()
  local currentI = Snacks.config.picker.ignored
  local currentH = Snacks.config.picker.hidden

  Snacks.config.picker.ignored = not currentI
  Snacks.config.picker.hidden = not currentH

  msg = Snacks.config.picker.ignored and "Snacks: ignored ON" or "Snacks: ignored OFF"
  Snacks.notify(msg)
end, { desc = "Toggle Snacks ignored files" })

-- Navigation
-- local function ctx_move(direction)
--   Snacks.notify("calling ctx_move")
--
--   local success = pcall(vim.cmd, "wincmd " .. direction)
--
--   local msg = success and "Success" or "Failed"
--   -- Snacks.notify(msg)
--
--   Snacks.notify("success: " .. tostring(success), { title = "Success" })
--
--   if not success then
--     Snacks.notify("wincmd failed calling tmux select-")
--     vim.fn.system("tmux select-pane " .. ({
--       h = "-L",
--       j = "-D",
--       k = "-U",
--       l = "-R",
--     })[direction])
--   end
-- end

local tmux_dirs = {
  h = "-L",
  j = "-D",
  k = "-U",
  l = "-R",
}

local function ctx_move(dir)
  local before = vim.api.nvim_get_current_win()

  vim.cmd("wincmd " .. dir)

  local after = vim.api.nvim_get_current_win()

  if before == after then
    vim.fn.system({ "tmux", "select-pane", tmux_dirs[dir] })
  end
end

vim.keymap.set("n", "<C-h>", function()
  ctx_move("h")
end)
vim.keymap.set("n", "<C-j>", function()
  ctx_move("j")
end)
vim.keymap.set("n", "<C-k>", function()
  ctx_move("k")
end)
vim.keymap.set("n", "<C-l>", function()
  ctx_move("l")
end)
