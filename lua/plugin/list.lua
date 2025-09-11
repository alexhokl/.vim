return {

  {
    "folke/todo-comments.nvim",
    opts = {},
  },

  {
    "folke/trouble.nvim",
    dependencies = { "folke/todo-comments.nvim" },
    opts = {},
    keys = {
      {
        "<leader>tr",
        function() require("trouble").toggle("lsp_references") end,
        desc = "Toggle references",
      },
      {
        "<leader>tdr",
        function() require("trouble").toggle("diagnostics") end,
        desc = "Toggle diagnostics (repository)",
      },
      {
        "<leader>tdf",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Toggle diagnostics (buffer)",
      },
      {
        "<leader>tt",
        function() require("trouble").toggle("todo") end,
        desc = "Toggle todo",
      },
    },
  },

}
