-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Custom keymaps
--
-- <leader>P page
vim.keymap.set("n", "<leader>po", "ggVGd", { desc = "Clear whole page", remap = true })

vim.keymap.set("n", "<leader>pl", function()
  vim.wo.list = not vim.wo.list
  vim.opt.list = not vim.opt.list
  local snacks = require("snacks")
  local current = snacks.config.indent.enabled

  if current then
    snacks.indent.disable()
  else
    snacks.indent.enable()
  end

  -- snacks.config.indent.enabled = not current
  vim.notify("Snacks indent " .. (snacks.config.indent.enabled and "enabled" or "disabled"))
end, { desc = "Toggle whitespace visibility" })
