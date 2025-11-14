-- https://github.com/catppuccin/nvim
-- https://catppuccin.com/palette/
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = not vim.g.vscode,
    opts = {
      transparent_background = true,
    },
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
        -- transparent = true,
        float = {
          transparent = false, -- enable transparent floating windows
          solid = true, -- use solid styling for floating windows, see |winborder|
        },
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
