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

-- Small terminal config (matches snacks.lua default)
local small_config = {
  win = {
    style = "float",
    height = 15,
    width = math.max(45, math.floor(vim.o.columns * 0.5)),
    border = "rounded",
  },
}

-- Large terminal config
local large_config = {
  win = {
    style = "float",
    height = vim.o.lines - 8,
    width = vim.o.columns - 16,
    border = "rounded",
  },
}

function M.toggle_terminal_size()
  local snacks = require("snacks")

  -- Get the current terminal instance
  local term = snacks.terminal.get()

  -- if not term or not term.win then
  --   -- No terminal open, just open with default size
  --   snacks.terminal.toggle()
  --   return
  -- end

  -- Close current terminal (suppress errors)
  pcall(function()
    term:close()
  end)

  -- Reopen with new size
  if is_fullscreen then
    pcall(function()
      snacks.terminal.toggle(nil, small_config)
    end)
    is_fullscreen = false
  else
    pcall(function()
      snacks.terminal.toggle(nil, large_config)
    end)
    is_fullscreen = true
  end
end

return M
