return {
  dir = "/home/devy/Projects/nvim_plugins/venn.nvim",
  name = "venn.nvim",
  config = function()
    -- venn.nvim: enable or disable keymappings
    function _G.Toggle_venn()
      local venn_enabled = vim.b.venn_enabled
      if not venn_enabled then
        vim.b.venn_enabled = true
        vim.cmd([[setlocal ve=all]])
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBoxR<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBoxR<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBoxR<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBoxR<CR>", { noremap = true })
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBoxR<CR>", { noremap = true })
      else
        vim.cmd([[setlocal ve=]])
        vim.api.nvim_buf_del_keymap(0, "n", "J")
        vim.api.nvim_buf_del_keymap(0, "n", "K")
        vim.api.nvim_buf_del_keymap(0, "n", "L")
        vim.api.nvim_buf_del_keymap(0, "n", "H")
        vim.api.nvim_buf_del_keymap(0, "v", "f")
        vim.b.venn_enabled = nil
      end
    end

    -- toggle keymappings for venn using <leader>v
    vim.keymap.set(
      "n",
      "<leader>v",
      Toggle_venn,
      { noremap = true, silent = true, desc = "Toggle venn diagram drawing" }
    )
  end,
}
