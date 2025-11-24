return {
  "mg979/vim-visual-multi",
  opts = {}, -- Your options go here
  lazy = false,
  config = function()
    -- Your configuration goes here
    -- Example: disable default mappings
    -- vim.g.vm_leader = ""
    -- Example: set custom mappings
    vim.keymap.set("n", "<leader>cn", "a<C-n>")
    vim.keymap.set("n", "<leader>cj", "a<C-j>")
  end,
}
