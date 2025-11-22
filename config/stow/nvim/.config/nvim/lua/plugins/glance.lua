-- FIX: this package
return {
  "dnlhc/glance.nvim",
  cmd = "Glance",
  keys = {
    "<leader>pgD",
    "<cmd>Glance definitions<cr>",
    desc = "Glance definitions",
  },
}

--     vim.keymap.set('n', '<leader>pgD', '<CMD>Glance definitions<CR>')
-- vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
-- vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
-- vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')
