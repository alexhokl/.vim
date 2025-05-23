return {

  {
    "mason-org/mason.nvim",
    opts = {},
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

}
