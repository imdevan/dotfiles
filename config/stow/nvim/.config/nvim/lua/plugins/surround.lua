return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  -- lazy = false,
  vscode = true,
  config = function()
    require("nvim-surround").setup()
  end,
}
