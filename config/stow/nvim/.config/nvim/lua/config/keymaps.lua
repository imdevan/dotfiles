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

-- Cache vim functions for better performance
local keymap_set = vim.keymap.set

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
-- keymap_set("n", ":", ":", { noremap = true })

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

-- Delete file
keymap_set("n", "<leader>fd", file_utils.delete_file, { desc = "Delete current file" })
keymap_set("n", "<leader>fD", file_utils.delete_file_and_close, { desc = "Delete file and close" })

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

keymap_set("n", "]t", todo_utils.jump_next, { desc = "Next todo comment" })
keymap_set("n", "[t", todo_utils.jump_prev, { desc = "Previous todo comment" })
keymap_set("n", "]T", todo_utils.jump_next_error, { desc = "Next error/warning todo comment" })

-- Glance
-- =====================================================================================================================

-- Glance
-- https://github.com/dnlhc/glance.nvim
-- TODO: move to glance.lua
keymap_set("n", "gR", "<CMD>Glance references<CR>", silent_opts)
keymap_set("n", "gY", "<CMD>Glance type_definitions<CR>", silent_opts)
keymap_set("n", "gM", "<CMD>Glance implementations<CR>", silent_opts)

-- =====================================================================================================================
-- Markdown
-- =====================================================================================================================

-- Insert line (language-specific)
keymap_set(
  "n",
  "<leader>pl",
  text_utils.insert_line,
  { desc = "Insert line (80 dashes for Markdown/MDX, 80 equals + comment for others)" }
)

-- Copy markdown headers by level
for i = 1, 6 do
  keymap_set("n", "<leader>phh" .. i, function()
    markdown_utils.copy_headers_by_level(i)
  end, { desc = "Paste header level " .. i .. " content at cursor" })
end

-- Convert line/selection into markdown header (levels 0-9)
for i = 0, 9 do
  keymap_set("n", "<leader>ph" .. i, function()
    markdown_utils.convert_line_to_header(i)
  end, { desc = "Convert line to header (H" .. i .. ")" })

  keymap_set("v", "<leader>ph" .. i, function()
    markdown_utils.convert_selection_to_header(i)
  end, { desc = "Convert selection to header (H" .. i .. ")" })
end

-- Toggle checkbox
keymap_set("n", "<leader>pC", markdown_utils.toggle_checkbox, { desc = "Toggle checkbox" })
keymap_set("x", "<leader>pC", markdown_utils.toggle_checkbox, { desc = "Toggle checkbox" })

-- Utils
-- =====================================================================================================================

-- Reset git hunk under cursor
keymap_set("n", "<leader>pgd", git_utils.reset_hunk, { desc = "Discard git hunk under cursor" })
keymap_set("n", "<leader>gz", git_utils.reset_hunk, { desc = "Discard git hunk under cursor" })

-- Evaluate math expression from selected text
keymap_set(
  "v",
  "<leader>pm",
  math_utils.evaluate_math_expression,
  { desc = "Evaluate math expression from selected text" }
)

-- Evaluate math expression on all numbers in selection
keymap_set(
  "v",
  "<leader>pM",
  math_utils.apply_math_to_numbers,
  { desc = "Apply math expression to all numbers in selection" }
)

-- Case (toggle)
-- TODO: validate and probably remap for convience
keymap_set("i", "<leader>pcc", "~", { desc = "Toggle case" })

-- Context-aware navigation

-- Logger
-- TODO: find a better logging solution similar to turbo console_log
keymap_set("n", "<leader>pcl", js_console_log, { desc = "[C]onsole [L]og variable" })

-- Create space
keymap_set("n", "<leader>ps", text_utils.create_space_below, { desc = "Create 5 lines below and move to the first" })
keymap_set("n", "<leader>pS", text_utils.create_space_above, { desc = "Create 5 lines above and move to the first" })

-- Do math!
keymap_set("n", "<leader>pm", math_utils.evaluate_and_insert, { desc = "Evaluate expression and insert result" })

-- Copy file path and line number(s)
-- Useful for referencing code in llm
keymap_set("n", "<leader>pf", file_utils.copy_file_path, { desc = "Copy file path and line number" })

-- Multiline
keymap_set("v", "<leader>pf", file_utils.copy_file_path_range, { desc = "Copy file path and line range" })

-- Spell checking
-- =====================================================================================================================

-- Navigate to next spelling error and show suggestions
keymap_set("n", "<leader>pa", spell_utils.next_spelling_error, { desc = "Next spelling error and show suggestions" })

-- Navigate to previous spelling error and show suggestions
keymap_set(
  "n",
  "<leader>sN",
  spell_utils.prev_spelling_error,
  { desc = "Previous spelling error and show suggestions" }
)

-- Show suggestions for word under cursor
keymap_set(
  "n",
  "<leader>ss",
  spell_utils.show_suggestions,
  { desc = "Show spelling suggestions for word under cursor" }
)

-- Toggle spell checking
keymap_set("n", "<leader>st", spell_utils.toggle_spell, { desc = "Toggle spell checking" })

-- Word count
-- =====================================================================================================================
keymap_set("v", "<leader>pc", text_utils.word_count, { desc = "Word and character count of selection" })

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
  keymap_set("n", "<leader>o" .. editor.key, function()
    open_in_editor.open_in_editor(editor.cmd)
  end, { desc = editor.desc })
end

-- Open parent folder in finder
keymap_set("n", "<leader>of", open_in_editor.open_parent_folder, { desc = "Open parent folder in Finder" })

-- =====================================================================================================================
-- UI toggles (t)
-- =====================================================================================================================

-- Snacks setup
local snacks = require("snacks")

-- Toggle indent lines
-- Default disable line indention indicators cuz I'm weird like that
snacks.indent.disable()
keymap_set("n", "<leader>tn", ui_utils.toggle_indent_lines, { desc = "Toggle indent lines", remap = true })

-- Toggle lazygit
keymap_set("n", "<C-g>", snacks.lazygit.open, {
  desc = "Toggle lazygit",
})

-- Toggle rainbow delimiters
keymap_set("n", "<leader>td", ui_utils.toggle_rainbow_delimiters, { desc = "Toggle rainbow delimiters", remap = true })

-- Toggle highlight colors
keymap_set(
  "n",
  "<leader>th",
  ui_utils.toggle_highlight_colors,
  { desc = "Toggle highlight colors (background/foreground)" }
)

-- Toggle snacks ignored files
keymap_set("n", "<leader>ti", ui_utils.toggle_snacks_ignored, { desc = "Toggle Snacks ignored files" })

-- Toggle type hints
keymap_set("n", "<leader>ty", ui_utils.toggle_type_hints, { desc = "Toggle type hints", remap = true })

-- Toggle color column
keymap_set("n", "<leader>tc", ui_utils.toggle_colorcolumn, { desc = "Toggle colorcolumn" })

-- Toggle bufferline / tab bar
keymap_set("n", "<leader>tb", ui_utils.toggle_bufferline, { desc = "Toggle bufferline / tab bar" })

-- Toggle cursor
keymap_set("n", "<leader>tc", ui_utils.toggle_cursor_style, {
  desc = "Toggle cursor underline | block ",
})

-- Render markdown
keymap_set("n", "<leader>pr", markdown_utils.toggle_render_markdown, {
  desc = "Toggle render markdown",
})

-- Toggle comment
-- Use LazyVim's default comment keymaps (gcc for line, gc for visual)
keymap_set("n", "<C-c>", "gcc", { desc = "Toggle comment", remap = true })
keymap_set("x", "<C-c>", "gc", { desc = "Toggle comment (visual)", remap = true })

-- Zen mode
-- Note: C-z is often intercepted by terminals for suspend (sends SIGTSTP)
-- If this doesn't work, the terminal is likely intercepting it before Neovim
keymap_set("n", "<C-i>", snacks.zen.zen, { desc = "Toggle zen" })
keymap_set("x", "<C-i>", snacks.zen.zen, { desc = "Toggle zen" })

-- Terminal
-- ============================================================================

keymap_set("n", "<C-x>", snacks.terminal.toggle, {
  desc = "Toggle multi Line Terminal",
})

keymap_set("t", "<C-x>", snacks.terminal.toggle, {
  desc = "Toggle multi Line Terminal",
})

-- Noice
-- =====================================================================================================================
keymap_set("n", "<leader>pi", "<CMD>Noice history<CR>", { desc = "Noice history" })
