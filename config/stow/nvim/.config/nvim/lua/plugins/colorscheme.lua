-- https://github.com/catppuccin/nvim
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
        -- transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        integrations = {
          treesitter = true,
          lsp_saga = true,
          cmp = true,
          gitsigns = true,
          telescope = true,
          notify = true,
          mini = true,
          native_lsp = {
            enabled = true,
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
