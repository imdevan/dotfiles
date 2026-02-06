-- TODO: fix single line terminal
-- -- Single line terminal
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
local M = {}

-- Track terminal size state
local is_fullscreen = false

-- Helper function to set small terminal size
local function set_small(win)
  local height = 15
  local width = math.max(45, math.floor(vim.o.columns * 0.5))

  vim.api.nvim_win_set_height(win, height)
  vim.api.nvim_win_set_width(win, width)

  -- Center the window
  local config = vim.api.nvim_win_get_config(win)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  config.row = row
  config.col = col
  vim.api.nvim_win_set_config(win, config)
end

-- Helper function to set large terminal size
local function set_large(win)
  local padding_y = 4
  local padding_x = 8
  local height = vim.o.lines - (padding_y * 2)
  local width = vim.o.columns - (padding_x * 2)

  vim.api.nvim_win_set_height(win, height)
  vim.api.nvim_win_set_width(win, width)

  -- Center the window
  local config = vim.api.nvim_win_get_config(win)
  config.row = padding_y
  config.col = padding_x
  vim.api.nvim_win_set_config(win, config)
end

function M.toggle_terminal_size()
  local snacks = require("snacks")

  -- Get the current terminal instance
  local term = snacks.terminal.get()

  if not term or not term.win then
    -- No terminal open, just open with default size
    snacks.terminal.toggle()
    return
  end

  -- Get the window
  local win = term.win

  if is_fullscreen then
    set_small(win)
    is_fullscreen = false
  else
    set_large(win)
    is_fullscreen = true
  end
end

return M
