local M = {}

local api = vim.api
local notify = vim.notify

-- Toggle indent lines
function M.toggle_indent_lines()
  local snacks = require("snacks")
  vim.wo.list = not vim.wo.list
  vim.opt.list = not vim.opt.list

  if snacks.indent.enabled then
    snacks.indent.disable()
  else
    snacks.indent.enable()
  end
end

-- Toggle rainbow delimiters
function M.toggle_rainbow_delimiters()
  local rainbow_delimiters = require("rainbow-delimiters")
  rainbow_delimiters.toggle(0)
end

-- Toggle highlight colors
function M.toggle_highlight_colors()
  local hl_groups = { "Visual", "Search", "IncSearch", "CurSearch", "Substitute" }
  local custom_bg = "#181926"
  local custom_fg = "#b7bdf8"

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
end

-- Toggle snacks ignored files
function M.toggle_snacks_ignored()
  local snacks = require("snacks")
  local current = snacks.config.picker.ignored
  snacks.config.picker.ignored = not current

  local msg = snacks.config.picker.ignored and "Snacks: ignored ON" or "Snacks: ignored OFF"
  snacks.notify(msg)
end

-- Toggle type hints
function M.toggle_type_hints()
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
end

-- Toggle color column
function M.toggle_colorcolumn()
  local current = vim.opt.colorcolumn:get()
  if current == "" then
    vim.opt.colorcolumn = "80"
    notify("ColorColumn: ON (80)", vim.log.levels.INFO)
  else
    vim.opt.colorcolumn = ""
    notify("ColorColumn: OFF", vim.log.levels.INFO)
  end
end

-- Toggle bufferline / tab bar
function M.toggle_bufferline()
  local current = vim.o.showtabline
  if current == 0 then
    vim.o.showtabline = 2
    notify("Bufferline: ON", vim.log.levels.INFO)
  else
    vim.o.showtabline = 0
    notify("Bufferline: OFF", vim.log.levels.INFO)
  end
end

-- Toggle cursor style
local cursor_underline = false

local underline_everywhere = table.concat({
  "n-v:hor100",
  "c-i:ver20",
  "r:block",
  "o:hor100",
}, ",")

local block_everywhere = table.concat({
  "n-v:block",
  "c-i:ver20",
  "r:hor20",
  "o:block",
}, ",")

function M.toggle_cursor_style()
  if cursor_underline then
    vim.opt.guicursor = block_everywhere
    pcall(function()
      require("smear_cursor").enabled = true
    end)
  else
    vim.opt.guicursor = underline_everywhere
    pcall(function()
      require("smear_cursor").enabled = false
    end)
  end

  cursor_underline = not cursor_underline
end

-- Toggle render markdown
local render_markdown_enabled = true

function M.toggle_render_markdown()
  if render_markdown_enabled then
    vim.cmd("RenderMarkdown disable")
  else
    vim.cmd("RenderMarkdown enable")
  end

  render_markdown_enabled = not render_markdown_enabled
end

return M
