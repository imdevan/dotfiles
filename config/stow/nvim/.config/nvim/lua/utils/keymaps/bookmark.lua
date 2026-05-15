local M = {}

function M.bookmark_file()
  local bookmark_dir = vim.fn.getcwd()
  local current_file = vim.fn.expand("%:.")

  vim.ui.input({ prompt = "Bookmark alias: " }, function(alias)
    if not alias or alias == "" then
      return
    end
    vim.fn.jobstart({ "bookmark", alias, "-t", "-d", bookmark_dir, "-f", current_file, "-y" }, {
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("Bookmarked: " .. alias, vim.log.levels.INFO)
        else
          vim.notify("bookmark failed (exit " .. code .. ")", vim.log.levels.ERROR)
        end
      end,
    })
  end)
end

return M
