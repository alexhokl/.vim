return {

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local vscode = require('dap.ext.vscode')
      local package_path = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/"
      local codelldb_path = package_path .. "codelldb/extension/adapter/codelldb"
      -- local netcoredbg_path = "/usr/local/netcoredbg"
      local flutter_path = os.getenv("HOME") .. "/git/flutter/bin/flutter"

      local default_keymap_options = { noremap = true, silent = true }

      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--port", "${port}" },
        }
      }

      -- dap.adapters.coreclr = {
      --  type = 'executable',
      --  command = netcoredbg_path,
      --  args = { '--interpreter=vscode' },
      -- }

      dap.adapters.dart = {
        type = 'executable',
        command = flutter_path,
        args = { 'debug_adapter' },
        -- toolArgs = { '--device-id', 'chrome' },
      }

      vscode.load_launchjs(nil, {
        coreclr = { "cs" },
        dart = { "dart" },
        codelldb = { "rust", "c", "cpp" },
      })

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- if vim.bo.filetype == "dart" then
      --  vim.keymap.set("n", "<F5>", ':FlutterRun<CR>', default_keymap_options)
      -- else
      --  vim.keymap.set("n", "<F5>", ':DapContinue<CR>', default_keymap_options)
      -- end
    end,
    keys = {
      { "<F9>",  ":DapToggleBreakpoint<CR>", { noremap = true, silent = true, desc = "Toggle Breakpoint" } },
      { "<F10>", ":DapStepOver<CR>",         { noremap = true, silent = true, desc = "Step Over" } },
      { "<F11>", ":DapStepInto<CR>",         { noremap = true, silent = true, desc = "Step Into" } },
      { "<F12>", ":DapStepOut<CR>",          { noremap = true, silent = true, desc = "Step Out" } },
      { "<F5>",  ":DapContinue<CR>",         { noremap = true, silent = true, desc = "Continue" } },
    },
  },

  {
    "leoluz/nvim-dap-go",
  },

  {
    "theHamsta/nvim-dap-virtual-text",
  },

  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local python = require("dap-python")
      local package_path = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/"
      local debugpy_path = package_path .. "debugpy/venv/bin/python"

      -- potentially breaks tree-sitter for python
      -- reference: https://github.com/mfussenegger/nvim-dap-python#tree-sitter
      python.setup(debugpy_path)
    end,
  },

  {
    "alexhokl/nvim-dap-dotnet",
    opts = {},
  },

}
