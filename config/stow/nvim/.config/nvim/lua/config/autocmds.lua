-- Autocmds are automatically loaded on the VeryLazy event
--
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable autoformat for md files
-- http://www.lazyvim.org/configuration/tips#:~:text=Navigating%20around%20multiple%20buffers%E2%80%8B,Core%20Plugins
-- <leader>uf to enable autoformat anyway for that buffer.
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "skhdrc" },
  callback = function()
    vim.bo.commentstring = "# %s"
  end,
})
