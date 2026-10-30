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
  -- language specific lsps
  {
    "AstroNvim/astrolsp",
    opts = {
      -- set configuration options  as described below
      -- Configure language servers with `vim.lsp.config` (`:h vim.lsp.config`)
      config = {
        -- Configure LSP defaults
        ["*"] = {
          -- Configure default capabilities
          capabilities = {
            textDocument = {
              foldingRange = { dynamicRegistration = false },
            },
          },
          -- Custom flags table to be passed to all language servers
          flags = {
            exit_timeout = 5000,
          },
        },
      },
    },
  },
}
