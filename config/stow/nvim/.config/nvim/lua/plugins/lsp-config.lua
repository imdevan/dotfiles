return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        ["*"] = {
          keys = {
            -- Add a keymap
            -- { "H", "<cmd>echo 'hello'<cr>", desc = "Say Hello" },
            -- Change an existing keymap
            { "<leader>K", "<cmd>echo 'custom hover'<cr>", desc = "Custom Hover" },
            -- Disable a keymap
            { "K", false },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
      },
    },
  },
}
