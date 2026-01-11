-- https://github.com/folke/snacks.nvim/tree/main/docs
-- https://github.com/folke/snacks.nvim/blob/main/docs/styles.md

-- additional snacks
return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.picker = {
      -- Side bar options
      hidden = true, -- for hidden files
      ignored = false, -- for .gitignore files

      sources = {
        -- Grep search settings
        -- Show hidden files
        -- Ignore .gitignore and the like
        grep = {
          hidden = true,
          ignored = false,
        },
      },
    }

    opts.terminal = {
      win = {
        style = "float",
        -- width = math.floor(vim.o.columns * 0.5),
        -- height = math.floor(vim.o.lines * 0.5),
        -- height = 1,
        -- height = 10,
        height = 15,
        -- height = 20,
        width = math.floor(vim.o.columns * 0.5),
        border = "rounded",
      },
    }

    opts.lazygit = {
      win = {
        border = false,
        height = math.floor(vim.o.columns),
        width = math.floor(vim.o.columns),
      },
    }

    -- Disable indent guide lines
    opts.indent = { enabled = false }
  end,
}
