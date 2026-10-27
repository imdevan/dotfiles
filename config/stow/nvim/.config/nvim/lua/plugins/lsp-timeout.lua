return {
  "toniher/lsp-timeout.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  -- load after lspconfig so :LspStart/:LspStop exist when the plugin checks for them
  event = "LspAttach",
  config = function()
    -- plugin's setup runs on VimEnter, which already fired by now
    vim.api.nvim_exec_autocmds("VimEnter", { group = "LSPTimeout" })
  end,
}
