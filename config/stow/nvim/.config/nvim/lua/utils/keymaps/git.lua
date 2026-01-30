local M = {}

-- Reset git hunk under cursor
function M.reset_hunk()
  require("gitsigns").reset_hunk()
end

return M
