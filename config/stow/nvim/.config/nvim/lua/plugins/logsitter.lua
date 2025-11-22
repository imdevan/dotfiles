return {}

-- FIX: get this working
--
-- return {
--   "gaelph/logsitter.nvim",
--   dependencies = { "nvim-treesitter/nvim-treesitter" },
--   config = function()
--     local logsitter = require("logsitter")
--
--     vim.keymap.set("n", "<leader>plg", function()
--       logsitter.log()
--     end)
--
--     -- experimental visual mode
--     vim.keymap.set("x", "<leader>plg", function()
--       logsitter.log_visual()
--     end)
--   end,
-- }
