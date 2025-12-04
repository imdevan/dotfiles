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
vim.keymap.set("n", "<leader>poc", "ggVGd", { desc = "Clear whole page" })

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

-- Toggle rainbow delimiters
vim.keymap.set("n", "<leader>pd", function()
  require("rainbow-delimiters").toggle(0)
end, { desc = "Toggle rainbow delimiters", remap = true })

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
vim.keymap.set("n", "<C-q>", "<CMD>quitall<CR>", { silent = true })
vim.keymap.set("n", "<C-Q>", "<CMD>quitall<CR>", { silent = true })
vim.keymap.set("i", "<C-q>", "<CMD>quitall<CR>", { silent = true })
vim.keymap.set("i", "<C-Q>", "<CMD>quitall<CR>", { silent = true })
vim.keymap.set("n", "<C-q>", "<CMD>quitall<CR>", { silent = true })
vim.keymap.set("n", "<C-Q>", "<CMD>quitall<CR>", { silent = true })
vim.keymap.set("i", "<C-q>", "<CMD>quitall<CR>", { silent = true })
vim.keymap.set("i", "<C-Q>", "<CMD>quitall<CR>", { silent = true })

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

-- Open parent folder in Finder
vim.keymap.set("n", "<leader>of", function()
  local parent_dir = vim.fn.expand("%:p:h")
  vim.fn.system({ "open", parent_dir })
  vim.notify("Opened parent folder in Finder: " .. parent_dir, vim.log.levels.INFO)
end, { desc = "Open parent folder in Finder" })

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

-- Create space
vim.keymap.set("n", "<leader>ps", function()
  -- Using 'o' enters insert mode, so we must return to normal mode
  vim.cmd("5normal o")
  -- Then move up 5 lines
  vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1] - 5, 0 })
end, { desc = "Create 5 lines below and move to the first" })

vim.keymap.set("n", "<leader>pS", function()
  -- Use "normal O" to insert lines above the current line
  vim.cmd("5normal O")
  -- The cursor is already on the top-most new line after this
end, { desc = "Create 5 lines above and move to the first" })

-- Navigation
local function ctx_move(dir)
  local tmux_dirs = {
    h = "-L",
    j = "-D",
    k = "-U",
    l = "-R",
  }

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

-- Toggle color column
vim.keymap.set("n", "<leader>puc", function()
  if vim.opt.colorcolumn:get() == "" then
    vim.opt.colorcolumn = "80" -- Set your desired column number
    vim.notify("ColorColumn: ON (80)", vim.log.levels.INFO)
  else
    vim.opt.colorcolumn = ""
    vim.notify("ColorColumn: OFF", vim.log.levels.INFO)
  end
end, { desc = "Toggle colorcolumn" })

-- Copy file path and line number(s)
vim.keymap.set("n", "<leader>pf", function()
  local filepath = vim.fn.expand("%:.")
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local content = filepath .. ":" .. line_num
  vim.fn.setreg("+", content)
  vim.notify("Copied: " .. content, vim.log.levels.INFO)
end, { desc = "Copy file path and line number" })

vim.keymap.set("v", "<leader>pf", function()
  local filepath = vim.fn.expand("%:.")
  -- Get visual selection range
  -- 'v' is the start of visual selection, '.' is current cursor position
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")

  -- Ensure start_line is less than or equal to end_line
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local content
  if start_line == end_line then
    content = filepath .. ":" .. start_line
  else
    content = filepath .. ":" .. start_line .. "-" .. end_line
  end

  vim.fn.setreg("+", content)
  vim.notify("Copied: " .. content, vim.log.levels.INFO)
end, { desc = "Copy file path and line range" })
