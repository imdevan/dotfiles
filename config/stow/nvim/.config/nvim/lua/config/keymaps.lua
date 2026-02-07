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
local open_in_editor = require("utils.keymaps.open_in_editor")
local js_console_log = require("utils.keymaps.js_console_log").js_console_log
local math_utils = require("utils.keymaps.math")
local markdown_utils = require("utils.keymaps.markdown")
local spell_utils = require("utils.keymaps.spell")
local text_utils = require("utils.keymaps.text")
local file_utils = require("utils.keymaps.file")
local git_utils = require("utils.keymaps.git")
local todo_utils = require("utils.keymaps.todo")
local ui_utils = require("utils.keymaps.ui")
local terminal_utils = require("utils.keymaps.terminal")

-- Cache vim functions for better performance
local set = vim.keymap.set

-- Multi set util
local function multi_set(modes, keys, action, opts)
  -- Split by comma
  local seperator = ","
  local mode_list = vim.split(modes, seperator, { trimempty = true })
  local key_list = vim.split(keys, seperator, { trimempty = true })

  -- Set keymap for each mode and key combination
  for _, mode in ipairs(mode_list) do
    for _, key in ipairs(key_list) do
      set(mode, key, action, opts)
    end
  end
end

-- which-key group labels
-- Use vim.schedule to ensure keymaps are registered before counting
vim.schedule(function()
  pcall(function()
    local wk = require("which-key")

    wk.add({
      { "<leader>p", group = " Personal" },
      { "<leader>ph", group = " Convert to header" },
      { "<leader>phh", group = " Copy headers" },
      { "<leader>po", group = " Open in editor" },
    })
  end)
end)

-- restore colon for normal mode
-- keep for restoring later if needed
-- set("n", ":", ":", { noremap = true })

-- output normal mode keymaps to file. keep for testing
-- vim.schedule(function()
--   local maps = vim.api.nvim_get_keymap("n")
--   local out = {}
--
--   for _, m in ipairs(maps) do
--     table.insert(out, string.format("lhs=%s rhs=%s expr=%s", m.lhs or "", m.rhs or "", tostring(m.expr)))
--   end
--
--   vim.fn.writefile(out, "/tmp/nmap_dump.txt")
-- end)

-- =====================================================================================================================
-- Global (escaped)
-- =====================================================================================================================
local silent_opts = { silent = true }

-- Save
set("n", "<M-s>", "<CMD>write<CR>", silent_opts)
set("i", "<M-s>", "<CMD>write<CR>", silent_opts)

-- Quit (consolidated duplicates)
multi_set("n,i", "<C-q>,<C-Q>", "<CMD>quitall<CR>", silent_opts)

-- Close current buffer
set("n", ";", "<CMD>bd<CR>", silent_opts)

-- Reload file
set("n", "<M-r>", "<CMD>e!<CR>", {
  desc = "Reload file from disk",
  remap = true,
})

-- Delete file
set("n", "<leader>fd", file_utils.delete_file, { desc = "Delete current file" })
set("n", "<leader>fD", file_utils.delete_file_and_close, { desc = "Delete file and close" })

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
set("n", "<leader>poc", "ggVGd", { desc = "Clear whole page" })
set("n", "<leader>pop", 'ggVG"0p', { desc = "Paste whole page", remap = true })
set("n", "<leader>poy", "ggVGy", { desc = "Yank whole page", remap = true })
set("n", "<M-a>", "ggVG", { desc = "Select all" })

-- Full word motions
-- =====================================================================================================================

-- Copy / Paste full word
local word_opts = { remap = true }
set("n", "<leader>py", "gbvey", vim.tbl_extend("force", word_opts, { desc = "Copy word (from anywhere in word)" }))
set("n", "<leader>pp", "gbvep", vim.tbl_extend("force", word_opts, { desc = "Paste word" }))

-- To end of line
set("n", "<leader>pY", "v$gey", vim.tbl_extend("force", word_opts, { desc = "Yank to end of line" }))
set("n", "<leader>pP", "v$gep", vim.tbl_extend("force", word_opts, { desc = "Paste to end of line" }))

-- Todo comments
-- =====================================================================================================================

set("n", "]t", todo_utils.jump_next, { desc = "Next todo comment" })
set("n", "[t", todo_utils.jump_prev, { desc = "Previous todo comment" })
set("n", "]T", todo_utils.jump_next_error, { desc = "Next error/warning todo comment" })

-- Glance
-- =====================================================================================================================

-- Glance
-- https://github.com/dnlhc/glance.nvim
-- TODO: move to glance.lua
set("n", "gR", "<CMD>Glance references<CR>", silent_opts)
set("n", "gY", "<CMD>Glance type_definitions<CR>", silent_opts)
set("n", "gM", "<CMD>Glance implementations<CR>", silent_opts)

-- =====================================================================================================================
-- Markdown
-- =====================================================================================================================

-- Insert line (language-specific)
set(
  "n",
  "<leader>pl",
  text_utils.insert_line,
  { desc = "Insert line (80 dashes for Markdown/MDX, 80 equals + comment for others)" }
)

-- Copy markdown headers by level
for i = 1, 6 do
  set("n", "<leader>phh" .. i, function()
    markdown_utils.copy_headers_by_level(i)
  end, { desc = "Paste header level " .. i .. " content at cursor" })
end

-- Convert line/selection into markdown header (levels 0-9)
for i = 0, 9 do
  set("n", "<leader>ph" .. i, function()
    markdown_utils.convert_line_to_header(i)
  end, { desc = "Convert line to header (H" .. i .. ")" })

  set("v", "<leader>ph" .. i, function()
    markdown_utils.convert_selection_to_header(i)
  end, { desc = "Convert selection to header (H" .. i .. ")" })
end

-- Render markdown
set("n", "<leader>pr", markdown_utils.toggle_render_markdown, {
  desc = "Toggle render markdown",
})

-- Toggle checkbox
multi_set("n,x", "<leader>pc", markdown_utils.toggle_checkbox, { desc = "Toggle checkbox" })

-- Toggle boldness
multi_set("n,x", "<leader>pb,<C-b>", markdown_utils.toggle_bold, { desc = "Toggle boldness" })

-- Utils
-- =====================================================================================================================

-- Reset git hunk under cursor
multi_set("n", "<leader>pgd,<leader>gz", git_utils.reset_hunk, { desc = "Discard git hunk under cursor" })

-- Quick commit
set("n", "<leader>ga", git_utils.lazy_commit, { desc = "Lazy add & commit" })

-- Calculator
set("n", "<leader>pm", math_utils.evaluate_and_insert, { desc = "Evaluate expression and insert result" })

-- Evaluate math expression from selected text
set("v", "<leader>pm", math_utils.evaluate_math_expression, { desc = "Evaluate math expression from selected text" })

-- Evaluate math expression on all numbers in selection
set("v", "<leader>pM", math_utils.apply_math_to_numbers, { desc = "Apply math expression to all numbers in selection" })

-- Case (toggle)
-- TODO: validate and probably remap for convience
set("i", "<leader>pcc", "~", { desc = "Toggle case" })

-- Context-aware navigation

-- Logger
-- TODO: find a better logging solution similar to turbo console_log
set("n", "<leader>pL", js_console_log, { desc = "[C]onsole [L]og variable" })

-- Create space
-- TODO: fix
set("n", "<leader>ps", text_utils.create_space_below, { desc = "Create 5 lines below and move to the first" })
set("n", "<leader>pS", text_utils.create_space_above, { desc = "Create 5 lines above and move to the first" })

-- Copy file path and line number(s)
-- Useful for referencing code in llm
set("n", "<leader>fp", file_utils.copy_file_path, { desc = "Copy file path and line number" })

set(
  "n",
  "<leader>fi",
  file_utils.implement_at_file_path,
  { desc = 'Copy file path and line number adds the word "implement"' }
)

-- Multiline
set("v", "<leader>pf", file_utils.copy_file_path_range, { desc = "Copy file path and line range" })

-- Spell checking
-- =====================================================================================================================

-- Navigate to next spelling error and show suggestions
set("n", "<leader>pa", spell_utils.next_spelling_error, { desc = "Next spelling error and show suggestions" })

-- Navigate to previous spelling error and show suggestions
set("n", "<leader>sN", spell_utils.prev_spelling_error, { desc = "Previous spelling error and show suggestions" })

-- Show suggestions for word under cursor
set("n", "<leader>ss", spell_utils.show_suggestions, { desc = "Show spelling suggestions for word under cursor" })

-- Toggle spell checking
set("n", "<leader>st", spell_utils.toggle_spell, { desc = "Toggle spell checking" })

-- Word count
-- =====================================================================================================================
set("v", "<leader>pwc", text_utils.word_count, { desc = "Word and character count of selection" })

-- Open in
-- =====================================================================================================================

-- Open in external editor
local editors = {
  { key = "v", cmd = "code", desc = "Open file and parent folder in VS Code" },
  { key = "c", cmd = "cursor", desc = "Open in Cursor at line" },
  { key = "k", cmd = "kiro", desc = "Open in Kiro at line" },
  { key = "g", cmd = "antigravity", desc = "Open in Antigravity at line" },
}

for _, editor in ipairs(editors) do
  set("n", "<leader>o" .. editor.key, function()
    open_in_editor.open_in_editor(editor.cmd)
  end, { desc = editor.desc })
end

-- Open parent folder in finder
set("n", "<leader>of", open_in_editor.open_parent_folder, { desc = "Open parent folder in Finder" })

-- =====================================================================================================================
-- UI toggles (t)
-- =====================================================================================================================

-- Snacks setup
local snacks = require("snacks")

-- Toggle indent lines
-- Default disable line indention indicators cuz I'm weird like that
snacks.indent.disable()
set("n", "<leader>tn", ui_utils.toggle_indent_lines, { desc = "Toggle indent lines", remap = true })

-- Toggle lazygit
set("n", "<C-g>", snacks.lazygit.open, {
  desc = "Toggle lazygit",
})

-- Toggle rainbow delimiters
set("n", "<leader>td", ui_utils.toggle_rainbow_delimiters, { desc = "Toggle rainbow delimiters", remap = true })

-- Toggle highlight colors
set("n", "<leader>th", ui_utils.toggle_highlight_colors, { desc = "Toggle highlight colors (background/foreground)" })

-- Toggle snacks ignored files
set("n", "<leader>ti", ui_utils.toggle_snacks_ignored, { desc = "Toggle Snacks ignored files" })

-- Toggle type hints
set("n", "<leader>ty", ui_utils.toggle_type_hints, { desc = "Toggle type hints", remap = true })

-- Toggle color column
set("n", "<leader>tu", ui_utils.toggle_colorcolumn, { desc = "Toggle colorcolumn" })

-- Toggle bufferline / tab bar
set("n", "<leader>tb", ui_utils.toggle_bufferline, { desc = "Toggle bufferline / tab bar" })

-- Toggle cursor
set("n", "<leader>tc", ui_utils.toggle_cursor_style, {
  desc = "Toggle cursor underline | block ",
})

-- Toggle comment
-- Use LazyVim's default comment keymaps (gcc for line, gc for visual)
set("n", "<C-c>", "gcc", { desc = "Toggle comment", remap = true })
-- set("x", "<C-c>", "gc", { desc = "Toggle comment (visual)", remap = true })
set("v", "<C-c>", text_utils.comment_swap, { desc = "Toggle comment (swap)", remap = true })

-- Zen mode
-- Note: C-z is often intercepted by terminals for suspend (sends SIGTSTP)
-- If this doesn't work, the terminal is likely intercepting it before Neovim
multi_set("n,x", "<C-i>", snacks.zen.zen, { desc = "Toggle zen" })

-- Terminal
-- ============================================================================

multi_set("n,t", "<C-x>", snacks.terminal.toggle, {
  desc = "Toggle multi Line Terminal",
})

set("t", "<C-t>", terminal_utils.toggle_terminal_size, { desc = "Toggle Terminal Size" })

-- Noice
-- =====================================================================================================================
set("n", "<leader>pi", "<CMD>Noice history<CR>", { desc = "Noice history" })
