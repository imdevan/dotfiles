local M = {}

local todo_comments = require("todo-comments")

-- Jump to next todo comment
function M.jump_next()
  todo_comments.jump_next()
end

-- Jump to previous todo comment
function M.jump_prev()
  todo_comments.jump_prev()
end

-- Jump to next error/warning todo comment
function M.jump_next_error()
  todo_comments.jump_next({ keywords = { "ERROR", "WARNING" } })
end

return M
