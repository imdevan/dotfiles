return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      html = { "prettier" },
      -- Disable shell formatting since most scripts use zsh-specific syntax
      sh = {},
      bash = {},
      zsh = {},
    },
    formatters = {
      stylua = {
        command = "stylua",
        args = { "--stdin-filepath", "$FILENAME", "-" },
        stdin = true,
      },
    },
  },
}

