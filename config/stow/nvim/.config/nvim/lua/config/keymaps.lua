-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Custom keymaps
--
-- <leader>P page
vim.keymap.set("n", "<leader>po", "ggVGd", { desc = "Clear whole page", remap = true })

-- default disable line indention indicators cuz im weird like that
local snacks = require("snacks")
snacks.indent.disable()

vim.keymap.set("n", "<leader>pl", function()
  vim.wo.list = not vim.wo.list
  vim.opt.list = not vim.opt.list
  local current = snacks.indent.enabled

  if current then
    snacks.indent.disable()
  else
    snacks.indent.enable()
  end

  vim.notify("Snacks indent " .. (not current and "enabled" or "disabled"))
end, { desc = "Toggle whitespace visibility" })

-- TODO: add keymap to toggle ignoring gitignore in searches
-- vim.keymap.set("n", "<leader>pi", function()
--   vim.wo.list = not vim.wo.list
--   vim.opt.list = not vim.opt.list
--   local current = snacks.picker.ignored;
--
--   if current then
--     snacks.indent.disable()
--   else
--     snacks.indent.enable()
--   end
--
--   vim.notify("Snacks ignored files " .. (not current and "enabled" or "disabled"))
-- end, { desc = "Toggle ignored files" })
--
