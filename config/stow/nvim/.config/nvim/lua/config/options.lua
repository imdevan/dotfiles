-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.diagnostic.config({ virtual_text = false })
-- Default diagnostics as disabled due to unknown word issue
-- TODO:: fix unknown word issue and default diagnostics to enabled
vim.diagnostic.enable(false)

-- Show all content - notably markdown comments
vim.opt.conceallevel = 0

-- Reload files on save
vim.opt.autoread = true

-- Trigger checktime on focus gain for better responsiveness
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  command = "if mode() != 'c' | checktime | endif",
})
-- Show column at 80 chars
vim.opt.colorcolumn = ""

-- Reduce timeout for key sequences (fixes space key delay)
-- TODO: figure what this is
vim.opt.timeoutlen = 200

vim.opt.scrolloff = 18
-- vim.opt.scrolloff = 24
-- vim.opt.scrolloff = 32
