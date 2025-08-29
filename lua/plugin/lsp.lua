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
    "onsails/lspkind-nvim",
  },

  {
    "Decodetalkers/csharpls-extended-lsp.nvim",
    ft = { "cs" },
  },

  {
    "akinsho/flutter-tools.nvim",
    opts = {
      debugger = {
        enabled = true
      },
    },
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
