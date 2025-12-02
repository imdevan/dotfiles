-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.diagnostic.config({ virtual_text = false })
-- Default diagnostics as disabled due to unknown word issue
-- TODO:: fix unknown word issue and default diagnostics to enabled
vim.diagnostic.enable(false)

-- Show all content - notably in markdown
vim.opt.conceallevel = 0

-- Reload files on save
vim.opt.autoread = true

-- Show column at 80 chars
vim.opt.colorcolumn = "80"
