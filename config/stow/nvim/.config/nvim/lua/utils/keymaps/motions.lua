local M = {}

local api = vim.api

-- Go to the first alpha character on the current line (ignores checkbox patterns like [x])
function M.go_to_first_alpha()
  local row = api.nvim_win_get_cursor(0)[1]
  local line = api.nvim_get_current_line()
  local pos = 1
  while pos <= #line do
    -- Skip checkbox pattern [x] / [ ] / [X] etc.
    local cb_s, cb_e = line:find("%[.%]", pos)
    local alpha_col = line:find("%a", pos)
    if not alpha_col then break end
    if cb_s and alpha_col >= cb_s and alpha_col <= cb_e then
      pos = cb_e + 1
    else
      api.nvim_win_set_cursor(0, { row, alpha_col - 1 })
      return
    end
  end
  api.nvim_win_set_cursor(0, { row, 0 })
end

return M
