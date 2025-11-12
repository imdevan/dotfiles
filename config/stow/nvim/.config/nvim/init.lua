-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if not vim.g.vscode then
  -- Load colorscheme and UI-related plugins
  vim.cmd("colorscheme catppuccin-macchiato") -- or your preferred theme
end

-- vim.opt.spellfile = "~/.config/nvim/spell/en.utf-8.add"
-- vim.opt.spellfile = "~/.config/nvim/spell"
