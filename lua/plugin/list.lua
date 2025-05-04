return {

  {
    "folke/todo-comments.nvim",
    opts = {},
  },

  {
    "folke/trouble.nvim",
    dependencies = { "folke/todo-comments.nvim" },
    config = function()
      local trouble = require("trouble")
      trouble.setup()
      -- Utility function for mapping keys
      local map = function(mode, keys, command, desc)
        vim.keymap.set(mode, keys, command, { noremap = true, silent = true, desc = desc })
      end

      local toggle = function(mode)
        trouble.toggle({
          mode = mode,
          focus = true,
        })
      end


      map("n", "<leader>tr", function() toggle('lsp_references') end, "Toggle references (trouble)")
      map("n", "<leader>td", function() toggle('diagnostics') end, "Toggle diagnostics (trouble)")
      map("n", "<leader>tt", function() toggle('todo') end, "Toggle todo (trouble)")
    end,
  },

}
