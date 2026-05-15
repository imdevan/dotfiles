-- shoutout https://www.youtube.com/watch?v=oYzZxi3SSnM&t=2s
return {
  "mfussenegger/nvim-dap",
  lazy = false,
  dependencies = {
    "leoluz/nvim-dap-go",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    require("dapui").setup()
    require("dap-go").setup()

    print("nvim-dap configure called")

    local dap, dapui = require("dap"), require("dapui")

    -- Python: attach to debugpy running in Docker on port 5678
    dap.adapters.python = {
      type = "server",
      host = "127.0.0.1",
      port = 5678,
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "attach",
        name = "Attach: Docker debugpy",
        connect = {
          host = "127.0.0.1",
          port = 5678,
        },
        pathMappings = {
          {
            localRoot = (function()
              local cwd = vim.fn.getcwd()
              if vim.fn.isdirectory(cwd .. "/app/backend") == 1 then
                return cwd .. "/app/backend"
              end
              return cwd
            end)(),
            remoteRoot = "/app",
          },
        },
      },
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<leader>dc", function()
      require("dap").continue()
    end, { desc = "Debug: Continue" })

    vim.keymap.set("n", "<leader>dv", function()
      require("dap").step_over()
    end, { desc = "Debug: Step Over" })

    vim.keymap.set("n", "<leader>di", function()
      require("dap").step_into()
    end, { desc = "Debug: Step Into" })

    vim.keymap.set("n", "<leader>do", function()
      require("dap").step_out()
    end, { desc = "Debug: Step Out" })

    vim.keymap.set("n", "<leader>db", function()
      require("dap").toggle_breakpoint()
    end, { desc = "Debug: Toggle Breakpoint" })

    vim.keymap.set("n", "<leader>dB", function()
      require("dap").set_breakpoint()
    end, { desc = "Debug: Set Breakpoint" })

    vim.keymap.set("n", "<leader>dl", function()
      require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = "Debug: Log Point" })

    vim.keymap.set("n", "<leader>dr", function()
      require("dap").repl.open()
    end, { desc = "Debug: Open REPL" })

    vim.keymap.set("n", "<leader>dL", function()
      require("dap").run_last()
    end, { desc = "Debug: Run Last" })

    vim.keymap.set("n", "<leader>du", function()
      dapui.open()
    end, { desc = "Debug: Open UI" })

    vim.keymap.set("n", "<leader>dU", function()
      dapui.close()
    end, { desc = "Debug: Close UI" })
  end,
}
