local M = {}

local log_file = vim.fn.stdpath("cache") .. "/editor_open.log"

function M.log(...)
  local msg = table.concat(
    vim.tbl_map(function(v)
      return vim.inspect(v)
    end, { ... }),
    " "
  )

  local f = io.open(log_file, "a")
  if f then
    f:write(os.date("%Y-%m-%d %H:%M:%S") .. "  " .. msg .. "\n")
    f:close()
  end
end

return M
