return {

  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- LSP servers
        "bash-language-server",
        "clangd",
        "cmake-language-server",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "eslint-lsp",
        "gopls",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "ocaml-lsp",
        "powershell-editor-services",
        "pyright",
        "roslyn",
        "rust-analyzer",
        "terraform-ls",
        "tflint",
        "tsgo",
        "vim-language-server",
        "yaml-language-server",
        "zls",
        -- DAP adapters
        "codelldb",
        "dart-debug-adapter",
        "debugpy",
        "delve",
        "netcoredbg",
        -- Formatters / linters
        "copilot-language-server",
        "sql-formatter",
      },
      auto_update = false,
      run_on_start = false,
    },
  },

  {
    "onsails/lspkind-nvim",
    opts = {},
  },

  {
    "Decodetalkers/csharpls-extended-lsp.nvim",
    ft = { "cs" },
  },

  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
    ft = { "dart" },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {},
  },

  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
    },
  },

}
