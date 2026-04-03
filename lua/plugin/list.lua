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
        "<cmd>Trouble lsp_references toggle<cr>",
        desc = "Toggle references",
      },
      {
        "<leader>tdr",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Toggle diagnostics (repository)",
      },
      {
        "<leader>tdf",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Toggle diagnostics (buffer)",
      },
      {
        "<leader>tt",
        "<cmd>Trouble todo toggle<cr>",
        desc = "Toggle todo",
      },
    },
  },

}
