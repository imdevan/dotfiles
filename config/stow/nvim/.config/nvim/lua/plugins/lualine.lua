-- the opts function can also be used to change the default opts:
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.sections = opts.sections or {}
    opts.sections.lualine_x = opts.sections.lualine_x or {}
    table.insert(opts.sections.lualine_x, function()
      return require("task-manager.statusline").summary()
    end)
  end,
}
