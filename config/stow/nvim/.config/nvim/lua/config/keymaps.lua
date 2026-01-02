-- Keymaps are automatically loaded on the VeryLazy event
--
-- Default keymaps
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- Docs
-- http://www.lazyvim.org/keymaps
--
-- Custom keymaps

-- Cache frequently used modules
local log = require("utils.logger").log
local open_in_editor = require("utils.open_in_editor").open_in_editor
local js_console_log = require("utils.js_console_log").js_console_log

-- Cache vim functions for better performance
local keymap_set = vim.keymap.set
local api = vim.api
local fn = vim.fn
local cmd = vim.cmd
local notify = vim.notify

-- =====================================================================================================================
-- Global (escaped)
-- =====================================================================================================================
local silent_opts = { silent = true }

-- Save
keymap_set("n", "<M-s>", "<CMD>write<CR>", silent_opts)
keymap_set("i", "<M-s>", "<CMD>write<CR>", silent_opts)

-- Quit (consolidated duplicates)
keymap_set("n", "<C-q>", "<CMD>quitall<CR>", silent_opts)
keymap_set("n", "<C-Q>", "<CMD>quitall<CR>", silent_opts)
keymap_set("i", "<C-q>", "<CMD>quitall<CR>", silent_opts)
keymap_set("i", "<C-Q>", "<CMD>quitall<CR>", silent_opts)

-- Reload file
keymap_set("n", "<M-r>", "<CMD>e!<CR>", {
  desc = "Reload file from disk",
  remap = true,
})

-- =====================================================================================================================
-- Personal (p)
-- =====================================================================================================================

-- Navigation
-- =====================================================================================================================
-- vim.keymap.set("n", "<C-h>", "<leader>wh", { desc = "window right", remap = true })
-- vim.keymap.set("n", "<C-l>", "<leader>wl", { desc = "window left", remap = true })

-- Full page motions
-- =====================================================================================================================

-- Full page operations
keymap_set("n", "<leader>poc", "ggVGd", { desc = "Clear whole page" })
keymap_set("n", "<leader>pop", 'ggVG"0p', { desc = "Paste whole page", remap = true })
keymap_set("n", "<leader>poy", "ggVGy", { desc = "Yank whole page", remap = true })
keymap_set("n", "<M-a>", "ggVG", { desc = "Select all" })

-- Full word motions
-- =====================================================================================================================

-- Copy / Paste full word
local word_opts = { remap = true }
keymap_set(
  "n",
  "<leader>py",
  "bvEy",
  vim.tbl_extend("force", word_opts, { desc = "Copy word (from anywhere in word)" })
)
keymap_set(
  "n",
  "<leader>pY",
  "BvEy",
  vim.tbl_extend("force", word_opts, { desc = "Copy Full word (from anywhere in word)" })
)
keymap_set("n", "<leader>pp", "bvEp", vim.tbl_extend("force", word_opts, { desc = "Paste word" }))
keymap_set("n", "<leader>pP", "BvEp", vim.tbl_extend("force", word_opts, { desc = "Paste Full word" }))

-- Todo comments
-- =====================================================================================================================

-- Todo comments
-- https://github.com/folke/todo-comments.nvim
local todo_comments = require("todo-comments")
keymap_set("n", "]t", function()
  todo_comments.jump_next()
end, { desc = "Next todo comment" })

keymap_set("n", "[t", function()
  todo_comments.jump_prev()
end, { desc = "Previous todo comment" })

-- Error/warning specific (use different key)
keymap_set("n", "]T", function()
  todo_comments.jump_next({ keywords = { "ERROR", "WARNING" } })
end, { desc = "Next error/warning todo comment" })

-- Glance
-- =====================================================================================================================

-- Glance
-- https://github.com/dnlhc/glance.nvim
-- TODO: move to glance.lua
keymap_set("n", "gR", "<CMD>Glance references<CR>", silent_opts)
keymap_set("n", "gY", "<CMD>Glance type_definitions<CR>", silent_opts)
keymap_set("n", "gM", "<CMD>Glance implementations<CR>", silent_opts)

-- Utils
-- =====================================================================================================================

-- Case (toggle)
-- TODO: validate and probably remap for convience
keymap_set("i", "<leader>pcc", "~", { desc = "Toggle case" })

-- Context-aware navigation
local tmux_dirs = {
  h = "-L",
  j = "-D",
  k = "-U",
  l = "-R",
}

local function ctx_move(dir)
  local before = api.nvim_get_current_win()
  cmd("wincmd " .. dir)
  local after = api.nvim_get_current_win()

  if before == after then
    fn.system({ "tmux", "select-pane", tmux_dirs[dir] })
  end
end

-- Create navigation keymaps efficiently
local nav_keys = { "H", "J", "K", "L" }
local nav_dirs = { "h", "j", "k", "l" }

for i, key in ipairs(nav_keys) do
  keymap_set("n", "<C-" .. key .. ">", function()
    ctx_move(nav_dirs[i])
  end, { desc = "Navigate " .. nav_dirs[i] })
end

-- Navigation end

-- Logger
-- TODO: find a better logging solution similar to turbo console_log
keymap_set("n", "<leader>pcl", js_console_log, { desc = "[C]onsole [L]og variable" })

-- Create space
keymap_set("n", "<leader>ps", function()
  cmd("5normal o")
  local current_line = api.nvim_win_get_cursor(0)[1]
  api.nvim_win_set_cursor(0, { current_line - 5, 0 })
end, { desc = "Create 5 lines below and move to the first" })

keymap_set("n", "<leader>pS", function()
  cmd("5normal O")
end, { desc = "Create 5 lines above and move to the first" })

-- Do math!
keymap_set("n", "<leader>pm", function()
  local keys = api.nvim_replace_termcodes("i<C-r>=", true, false, true)
  api.nvim_feedkeys(keys, "n", false)
end, { desc = "Evaluate expression and insert result" })

-- Copy file path and line number(s)
-- Useful for referencing code in llm
keymap_set("n", "<leader>pf", function()
  local filepath = fn.expand("%:.")
  local line_num = api.nvim_win_get_cursor(0)[1]
  local content = filepath .. ":" .. line_num
  fn.setreg("+", content)
  notify("Copied: " .. content, vim.log.levels.INFO)
end, { desc = "Copy file path and line number" })

-- Multiline
keymap_set("v", "<leader>pf", function()
  local filepath = fn.expand("%:.")
  local start_line = fn.line("v")
  local end_line = fn.line(".")

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local content = start_line == end_line and filepath .. ":" .. start_line
    or filepath .. ":" .. start_line .. "-" .. end_line

  fn.setreg("+", content)
  notify("Copied: " .. content, vim.log.levels.INFO)
end, { desc = "Copy file path and line range" })

-- Open in
-- =====================================================================================================================

-- Open in external editor
local editors = {
  { key = "v", cmd = "code", desc = "Open file and parent folder in VS Code" },
  { key = "c", cmd = "cursor", desc = "Open in Cursor at line" },
  { key = "k", cmd = "kiro", desc = "Open in Kiro at line" },
}

for _, editor in ipairs(editors) do
  keymap_set("n", "<leader>o" .. editor.key, function()
    open_in_editor(editor.cmd)
  end, { desc = editor.desc })
end

-- Open parent folder in finder
keymap_set("n", "<leader>of", function()
  local parent_dir = fn.expand("%:p:h")
  fn.system({ "open", parent_dir })
  notify("Opened parent folder in Finder: " .. parent_dir, vim.log.levels.INFO)
end, { desc = "Open parent folder in Finder" })

-- =====================================================================================================================
-- UI toggles (t)
-- =====================================================================================================================

-- Snacks setup
local snacks = require("snacks")

-- Default disable line indention indicators cuz im weird like that
snacks.indent.disable()

-- Toggle indent lines
keymap_set("n", "<leader>tn", function()
  vim.wo.list = not vim.wo.list
  vim.opt.list = not vim.opt.list

  if snacks.indent.enabled then
    snacks.indent.disable()
  else
    snacks.indent.enable()
  end
end, { desc = "Toggle indent lines", remap = true })

-- Toggle rainbow delimiters
local rainbow_delimiters = require("rainbow-delimiters")
keymap_set("n", "<leader>td", function()
  rainbow_delimiters.toggle(0)
end, { desc = "Toggle rainbow delimiters", remap = true })

-- Toggle highlight colors
local hl_groups = { "Visual", "Search", "IncSearch", "CurSearch", "Substitute" }
local custom_bg = "#181926"
local custom_fg = "#b7bdf8"

keymap_set("n", "<leader>th", function()
  local hl_state = vim.w.hl_toggle_state or {}
  local is_custom = hl_state.custom or false

  for _, group in ipairs(hl_groups) do
    if is_custom then
      -- Restore original colors
      if hl_state[group] then
        api.nvim_set_hl(0, group, hl_state[group])
      end
    else
      -- Store and set custom colors
      if not hl_state[group] then
        hl_state[group] = api.nvim_get_hl(0, { name = group })
      end
      api.nvim_set_hl(0, group, {
        bg = custom_bg,
        fg = custom_fg,
        reverse = false,
      })
    end
  end

  hl_state.custom = not is_custom
  vim.w.hl_toggle_state = hl_state

  local msg = is_custom and "Highlight colors: restored" or "Highlight colors: custom (#181926/#b7bdf8)"
  notify(msg, vim.log.levels.INFO)
end, { desc = "Toggle highlight colors (background/foreground)" })

-- Toggle snacks ignored files
keymap_set("n", "<leader>ti", function()
  local current = snacks.config.picker.ignored
  -- local currentH = snacks.config.picker.hidden
  snacks.config.picker.ignored = not current

  local msg = snacks.config.picker.ignored and "Snacks: ignored ON" or "Snacks: ignored OFF"
  snacks.notify(msg)
end, { desc = "Toggle Snacks ignored files" })

-- Toggle type hints
keymap_set("n", "<leader>ty", function()
  local bufnr = api.nvim_get_current_buf()
  local enabled = vim.b.inlay_hints_enabled
  if enabled == nil then
    -- First time: default to true (hints are usually on by default)
    enabled = true
  end

  if enabled then
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    vim.b.inlay_hints_enabled = false
    notify("Type hints: OFF", vim.log.levels.INFO)
  else
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    vim.b.inlay_hints_enabled = true
    notify("Type hints: ON", vim.log.levels.INFO)
  end
end, { desc = "Toggle type hints", remap = true })

-- Toggle color column
keymap_set("n", "<leader>tc", function()
  local current = vim.opt.colorcolumn:get()
  if current == "" then
    vim.opt.colorcolumn = "80"
    notify("ColorColumn: ON (80)", vim.log.levels.INFO)
  else
    vim.opt.colorcolumn = ""
    notify("ColorColumn: OFF", vim.log.levels.INFO)
  end
end, { desc = "Toggle colorcolumn" })
