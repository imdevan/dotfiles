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
local del = vim.keymap.del
local api = vim.api
local fn = vim.fn
local cmd = vim.cmd
local notify = vim.notify

-- which-key group labels
pcall(function()
  local wk = require("which-key")
  wk.add({
    { "<leader>p", group = "Personal" },
    { "<leader>ph", group = "Convert to header" },
  })
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

-- Reset git hunk under cursor
keymap_set("n", "<leader>pgd", function()
  require("gitsigns").reset_hunk()
end, { desc = "Discard git hunk under cursor" })

keymap_set("n", "<leader>gz", function()
  require("gitsigns").reset_hunk()
end, { desc = "Discard git hunk under cursor" })

-- Evaluate math expression from selected text
keymap_set("v", "<leader>pm", function()
  -- Save current selection to register
  cmd('normal! "vy')
  local selected_text = fn.getreg("v")

  if selected_text == "" then
    notify("No selection", vim.log.levels.WARN)
    return
  end

  -- Trim whitespace and newlines
  selected_text = selected_text:gsub("^%s+", ""):gsub("%s+$", ""):gsub("\n", "")

  -- Evaluate using Lua with math environment
  local success, result = pcall(function()
    local math_env = setmetatable({}, { __index = math })
    math_env.pi = math.pi
    math_env.e = math.exp(1)
    local func = load("return " .. selected_text, "math_eval", "t", math_env)
    if func then
      return func()
    end
    return nil
  end)

  if success and result ~= nil then
    local result_str = tostring(result)
    -- Replace selection with result
    cmd("normal! gvc" .. result_str)
    notify("Evaluated: " .. selected_text .. " = " .. result_str, vim.log.levels.INFO)
  else
    notify("Failed to evaluate: " .. selected_text, vim.log.levels.ERROR)
  end
end, { desc = "Evaluate math expression from selected text" })

-- Evaluate math expression on all numbers in selection
keymap_set("v", "<leader>pM", function()
  -- Save current selection to register
  cmd('normal! "vy')
  local selected_text = fn.getreg("v")

  if selected_text == "" then
    notify("No selection", vim.log.levels.WARN)
    return
  end

  -- Prompt for math expression
  local expr = fn.input("Math expression (e.g., 16, +16, *2, -5, /3): ")
  if expr == "" then
    notify("No expression provided", vim.log.levels.WARN)
    return
  end

  -- Determine operator and value
  -- If expression starts with operator, use it; otherwise default to addition
  local operator, value_str
  if expr:match("^[+%-*/]") then
    operator = expr:sub(1, 1)
    value_str = expr:sub(2)
  else
    -- Default to addition if just a number is provided
    operator = "+"
    value_str = expr
  end

  local success, value = pcall(function()
    return tonumber(value_str)
  end)

  if not success or not value then
    notify("Invalid number: " .. value_str, vim.log.levels.ERROR)
    return
  end

  -- Function to apply math operation to a number
  local function apply_operation(num_str)
    local num = tonumber(num_str)
    if not num then
      return num_str -- Return original if not a number
    end

    local result
    if operator == "+" then
      result = num + value
    elseif operator == "-" then
      result = num - value
    elseif operator == "*" then
      result = num * value
    elseif operator == "/" then
      if value == 0 then
        notify("Division by zero", vim.log.levels.ERROR)
        return num_str
      end
      result = num / value
    else
      return num_str
    end

    -- Preserve format: if original was integer and result is whole, return integer
    -- Otherwise preserve decimal precision
    if num_str:match("^%-?%d+$") and result == math.floor(result) then
      -- Was integer, result is whole number
      return tostring(math.floor(result))
    elseif num_str:match("%.") then
      -- Had decimal point, try to preserve similar precision
      local decimals = num_str:match("%.(%d+)")
      local precision = decimals and #decimals or 2
      return string.format("%." .. precision .. "f", result)
    else
      -- Integer input but fractional result
      return tostring(result)
    end
  end

  -- Replace all numbers in the selected text
  -- Pattern: matches numbers (including negative and decimal)
  local processed_text = selected_text:gsub("([%-%+]?%d+%.?%d*)", apply_operation)

  -- Check if text was actually modified
  if processed_text == selected_text then
    notify("No numbers found in selection", vim.log.levels.WARN)
    return
  end

  -- Get visual selection boundaries
  local start_pos = api.nvim_buf_get_mark(0, "<")
  local end_pos = api.nvim_buf_get_mark(0, ">")
  local start_line, start_col = start_pos[1] - 1, start_pos[2] -- Convert to 0-indexed
  local end_line, end_col = end_pos[1] - 1, end_pos[2]

  -- Split processed text into lines
  local processed_lines = vim.split(processed_text, "\n", { plain = true })

  -- Get current lines
  local lines = api.nvim_buf_get_lines(0, start_line, end_line + 1, false)

  if #lines == 0 then
    notify("No lines to process", vim.log.levels.WARN)
    return
  end

  -- Handle replacement based on selection type
  if start_line == end_line then
    -- Single line: replace portion between start_col and end_col
    local line = lines[1]
    -- start_col is 0-indexed, Lua strings are 1-indexed
    -- before: characters 1 to start_col (inclusive)
    local before = start_col > 0 and line:sub(1, start_col) or ""
    -- after: characters after end_col (end_col is inclusive, so +2 for next char)
    local after = line:sub(end_col + 2)
    lines[1] = before .. processed_lines[1] .. after
  else
    -- Multi-line: replace first line from start_col, middle lines entirely, last line up to end_col
    if #processed_lines > 0 then
      -- First line
      local first_line = lines[1]
      local before = start_col > 0 and first_line:sub(1, start_col) or ""
      lines[1] = before .. processed_lines[1]
      table.remove(processed_lines, 1)

      -- Middle lines
      for i = 2, #lines - 1 do
        if #processed_lines > 0 then
          lines[i] = processed_lines[1]
          table.remove(processed_lines, 1)
        end
      end

      -- Last line
      if #processed_lines > 0 and #lines > 1 then
        local last_line = lines[#lines]
        local after = last_line:sub(end_col + 2)
        lines[#lines] = processed_lines[1] .. after
      end
    end
  end

  -- Replace the lines in the buffer
  api.nvim_buf_set_lines(0, start_line, end_line + 1, false, lines)

  notify("Applied " .. (operator == "+" and expr or operator .. value_str) .. " to all numbers", vim.log.levels.INFO)
end, { desc = "Apply math expression to all numbers in selection" })

-- Case (toggle)
-- TODO: validate and probably remap for convience
keymap_set("i", "<leader>pcc", "~", { desc = "Toggle case" })
-- Context-aware navigation
-- local tmux_dirs = {
--   h = "-L",
--   j = "-D",
--   k = "-U",
--   l = "-R",
-- }
--
-- local function ctx_move(dir)
--   local before = api.nvim_get_current_win()
--   cmd("wincmd " .. dir)
--   local after = api.nvim_get_current_win()
--
--   if before == after then
--     fn.system({ "tmux", "select-pane", tmux_dirs[dir] })
--   end
-- end
--
-- -- Create navigation keymaps efficiently
-- local nav_keys = { "H", "J", "K", "L" }
-- local nav_dirs = { "h", "j", "k", "l" }
--
-- for i, key in ipairs(nav_keys) do
--   keymap_set("n", "<C-" .. key .. ">", function()
--     ctx_move(nav_dirs[i])
--   end, { desc = "Navigate " .. nav_dirs[i] })
-- end

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

-- Insert line (language-specific)
keymap_set("n", "<leader>pl", function()
  local filetype = vim.bo.filetype
  local current_line = api.nvim_win_get_cursor(0)[1]

  if filetype == "markdown" or filetype == "mdx" then
    -- Insert 80 dashes for Markdown/MDX
    local dash_line = string.rep("-", 80)
    api.nvim_buf_set_lines(0, current_line, current_line, false, { dash_line })
    api.nvim_win_set_cursor(0, { current_line + 1, 0 })
  else
    -- Insert 80 equals and comment for other languages
    local equals_line = string.rep("=", 80)
    api.nvim_buf_set_lines(0, current_line, current_line, false, { equals_line })
    -- Move to the new line and comment it
    api.nvim_win_set_cursor(0, { current_line + 1, 0 })
    -- Use schedule to ensure buffer update completes before commenting
    vim.schedule(function()
      cmd("normal gcc")
    end)
  end
end, { desc = "Insert line (80 dashes for Markdown/MDX, 80 equals + comment for others)" })

-- Copy markdown headers by level
local function copy_headers_by_level(level)
  -- Validate level is between 1 and 6
  if level < 1 or level > 6 then
    vim.notify("Header level must be between 1 and 6", vim.log.levels.ERROR)
    return
  end

  -- Build the header pattern (e.g., "^## " for level 2)
  local hashes = string.rep("#", level)
  local pattern = "^" .. hashes .. " "

  -- Clear register a
  vim.fn.setreg("a", "")

  -- Save cursor position
  local save_pos = vim.fn.getpos(".")

  -- Search for headers and collect text after them
  vim.cmd(string.format([[g/%s/s/%s\(.*\)/\=setreg('A', submatch(1)."\n")/n]], pattern, pattern))

  -- Restore cursor position
  vim.fn.setpos(".", save_pos)

  -- Paste the collected content
  vim.cmd('normal! "ap')

  vim.notify(string.format("Copied all level %d headers to cursor", level), vim.log.levels.INFO)
end

-- Create keymaps for ph1 through ph6
for i = 1, 6 do
  keymap_set("n", "<leader>pph" .. i, function()
    copy_headers_by_level(i)
  end, { desc = "Paste header level " .. i .. " content at cursor" })
end

-- Convert line/selection into markdown header (levels 0-9)
local function convert_lines_to_header(level, start_line, end_line)
  if level < 0 or level > 9 then
    notify("Header level must be between 0 and 9", vim.log.levels.ERROR)
    return
  end

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local bufnr = 0
  local lines = api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
  local hashes = level > 0 and string.rep("#", level) or nil

  for idx, line in ipairs(lines) do
    local indent = line:match("^%s*") or ""
    local rest = line:sub(#indent + 1)
    local title = rest:gsub("^#+%s*", ""):gsub("^%s+", ""):gsub("%s+$", "")

    if level == 0 then
      -- Strip any existing markdown header prefix.
      lines[idx] = title == "" and indent or (indent .. title)
    else
      if title == "" then
        lines[idx] = indent .. hashes
      else
        lines[idx] = indent .. hashes .. " " .. title
      end
    end
  end

  api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, lines)
end

for i = 0, 9 do
  keymap_set("n", "<leader>ph" .. i, function()
    local line = api.nvim_win_get_cursor(0)[1]
    convert_lines_to_header(i, line, line)
  end, { desc = "Convert line to header (H" .. i .. ")" })

  keymap_set("v", "<leader>ph" .. i, function()
    local start_line = fn.line("v")
    local end_line = fn.line(".")
    convert_lines_to_header(i, start_line, end_line)
  end, { desc = "Convert selection to header (H" .. i .. ")" })
end

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

-- Spell checking
-- =====================================================================================================================

-- Helper function to show spell suggestions (built-in prompt)
local function show_spell_suggestions()
  -- `z=` opens the built-in suggestions list for the word under cursor
  cmd("normal! z=")
end

-- Navigate to next spelling error and show suggestions
keymap_set("n", "<leader>pa", function()
  -- Enable spell checking if not already enabled
  if not vim.wo.spell then
    vim.wo.spell = true
    notify("Spell checking enabled", vim.log.levels.INFO)
  end

  -- Simply execute ]s to jump to next error, then show suggestions
  -- The ]s command will move to the next error or stay put if none found
  cmd("normal! ]s")
  vim.schedule(function()
    cmd("normal z=")
  end)
end, { desc = "Next spelling error and show suggestions" })

-- Navigate to previous spelling error and show suggestions
keymap_set("n", "<leader>sN", function()
  -- Enable spell checking if not already enabled
  if not vim.wo.spell then
    vim.wo.spell = true
    notify("Spell checking enabled", vim.log.levels.INFO)
  end

  -- Simply execute [s to jump to previous error, then show suggestions
  cmd("normal! [s")

  show_spell_suggestions()
end, { desc = "Previous spelling error and show suggestions" })

-- Show suggestions for word under cursor
keymap_set("n", "<leader>ss", function()
  if not vim.wo.spell then
    vim.wo.spell = true
    notify("Spell checking enabled", vim.log.levels.INFO)
  end
  show_spell_suggestions()
end, { desc = "Show spelling suggestions for word under cursor" })

-- Toggle spell checking
keymap_set("n", "<leader>st", function()
  vim.wo.spell = not vim.wo.spell
  local status = vim.wo.spell and "ON" or "OFF"
  notify("Spell checking: " .. status, vim.log.levels.INFO)
end, { desc = "Toggle spell checking" })

-- Word count
-- =====================================================================================================================
vim.keymap.set("v", "<leader>pc", function()
  vim.cmd('normal! "zy')
  local text = vim.fn.getreg("z")
  local chars = vim.fn.strlen(text)
  local words = #vim.split(text, "%s+", { trimempty = true })
  print("Words: " .. words .. " | Characters: " .. chars)
end, { desc = "Word and character count of selection" })

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

-- Toggle indent lines
-- Default disable line indention indicators cuz I'm weird like that
snacks.indent.disable()
keymap_set("n", "<leader>tn", function()
  vim.wo.list = not vim.wo.list
  vim.opt.list = not vim.opt.list

  if snacks.indent.enabled then
    snacks.indent.disable()
  else
    snacks.indent.enable()
  end
end, { desc = "Toggle indent lines", remap = true })

-- Toggle lazygit
keymap_set("n", "<C-g>", snacks.lazygit.open, {
  desc = "Toggle lazygit",
})

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
  -- local current = snacks.config.picker.hidden
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

-- Remap comments
-- Use LazyVim's default comment keymaps (gcc for line, gc for visual)
keymap_set("n", "<C-c>", "gcc", { desc = "Toggle comment", remap = true })
keymap_set("x", "<C-c>", "gc", { desc = "Toggle comment (visual)", remap = true })

-- Zen mode
-- Note: C-z is often intercepted by terminals for suspend (sends SIGTSTP)
-- If this doesn't work, the terminal is likely intercepting it before Neovim
keymap_set("n", "<C-i>", snacks.zen.zen, { desc = "Toggle zen" })
keymap_set("x", "<C-i>", snacks.zen.zen, { desc = "Toggle zen" })

-- Terminal shinanigans
-- ============================================================================

-- Single line terminal
-- local function toggle_single_line_terminal()
--   snacks.terminal.toggle({
--     id = "single-line",
--     shell = vim.o.shell,
--     style = "float",
--     height = 1,
--     width = math.floor(vim.o.columns * 0.5),
--     border = "rounded",
--   })
-- end
--
-- keymap_set("n", "<M-/>", toggle_single_line_terminal, {
--   desc = "Toggle Single Line Terminal",
-- })
-- keymap_set("t", "<M-/>", toggle_single_line_terminal, {
--   desc = "Toggle Single Line Terminal",
-- })
--
-- -- Multi line terminal
-- local function toggle_multi_line_terminal()
--   -- snacks.terminal.toggle()
-- snacks.terminal.toggle({
--   id = "multi-line",
--   shell = vim.o.shell,
--   style = "float",
--   height = 15,
--   width = math.floor(vim.o.columns * 0.5),
--   border = "rounded",
-- })
-- end

keymap_set("n", "<C-x>", snacks.terminal.toggle, {
  desc = "Toggle multi Line Terminal",
})

keymap_set("t", "<C-x>", snacks.terminal.toggle, {
  desc = "Toggle multi Line Terminal",
})

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
