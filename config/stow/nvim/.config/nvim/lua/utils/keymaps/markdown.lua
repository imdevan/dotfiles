local M = {}

local api = vim.api
local fn = vim.fn
local notify = vim.notify

-- Copy markdown headers by level
function M.copy_headers_by_level(level)
  -- Validate level is between 1 and 6
  if level < 1 or level > 6 then
    notify("Header level must be between 1 and 6", vim.log.levels.ERROR)
    return
  end

  -- Build the header pattern (e.g., "^## " for level 2)
  local hashes = string.rep("#", level)
  local pattern = "^" .. hashes .. " "

  -- Clear register a
  fn.setreg("a", "")

  -- Save cursor position
  local save_pos = fn.getpos(".")

  -- Search for headers and collect text after them
  vim.cmd(string.format([[g/%s/s/%s\(.*\)/\=setreg('A', submatch(1)."\n")/n]], pattern, pattern))

  -- Restore cursor position
  fn.setpos(".", save_pos)

  -- Paste the collected content
  vim.cmd('normal! "ap')

  notify(string.format("Copied all level %d headers to cursor", level), vim.log.levels.INFO)
end

-- Convert line/selection into markdown header (levels 0-9)
function M.convert_lines_to_header(level, start_line, end_line)
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

-- Convert current line to header
function M.convert_line_to_header(level)
  local api = vim.api
  local line = api.nvim_win_get_cursor(0)[1]
  M.convert_lines_to_header(level, line, line)
end

-- Convert visual selection to header
function M.convert_selection_to_header(level)
  local fn = vim.fn
  local start_line = fn.line("v")
  local end_line = fn.line(".")
  M.convert_lines_to_header(level, start_line, end_line)
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
