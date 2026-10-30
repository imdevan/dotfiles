return {
  "stevearc/conform.nvim",
  opts = {
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
      html = { "prettier" },
      -- css = { "prettier" },
      -- javascript = { "prettier" },
      -- javascriptreact = { "prettier" },
      -- typescript = { "prettier" },
      -- typescriptreact = { "prettier" },
      -- json = { "prettier" },
    },
  },
}
