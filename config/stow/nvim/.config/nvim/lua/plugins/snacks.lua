-- additional snacks
return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.picker = {
      -- Side bar options
      hidden = true, -- for hidden files
      ignored = true, -- for .gitignore files

      sources = {
        -- Grep search settings
        grep = {
          hidden = true,
          ignored = false,
        },
      },
    }

    -- Disable indent guide lines
    opts.indent = { enabled = false }
  end,
}
