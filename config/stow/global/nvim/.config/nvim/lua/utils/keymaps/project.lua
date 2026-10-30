-- utils/keymaps/project.lua

local M = {}

--- Prompt for a project name and insert a URL of the form "https://devan.gg/{project}/"
function M.insert_project_url()
  local project = vim.fn.input("Project: ")
  if not project or project == "" then
    return
  end
  local url = "https://devan.gg/" .. project .. "/"
  vim.api.nvim_put({ url }, "c", true, true)
end

return M
