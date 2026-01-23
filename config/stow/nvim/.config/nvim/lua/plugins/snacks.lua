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
        height = math.floor(vim.o.lines),
        width = math.floor(vim.o.columns),
      },
    }

    -- Disable indent guide lines
    opts.indent = { enabled = false }

    -- Zen Mode options
    opts.zen = {
      -- You can add any `Snacks.toggle` id here.
      -- Toggle state is restored when the window is closed.
      -- Toggle config options are NOT merged.
      ---@type table<string, boolean>
      toggles = {
        dim = false,
        git_signs = true,
        mini_diff_signs = true,
        -- diagnostics = false,
        -- inlay_hints = false,
      },
      win = {
        height = math.floor(vim.o.lines - 6),
        width = 180,
        -- minimal = true,
      },
      on_open = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
      end,
      on_close = function()
        vim.wo.number = true
        vim.wo.relativenumber = true
      end,
    }
  end,
}
