return {
  "chrisgrieser/nvim-spider",
  lazy = true,
  -- alt motion traversal
  keys = {
    { "<M-w>", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
    { "<M-e>", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
    { "<M-b>", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
    { "<M-g>e", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
  },
}
