return {

  {
    "folke/twilight.nvim",
    opts = {
      context = 5,
    },
    config = function()
      local twilight = require("twilight")
      twilight.setup()
      vim.keymap.set("n", "<leader>ll", twilight.toggle, { desc = "Toggle line spotlight", noremap = true })
    end,
  },

  {
    "rcarriga/nvim-notify",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      timeout = 5000,
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      local telescope = package.loaded.telescope
      telescope.load_extension("notify")
    end,
  },

  {
    "ntpeters/vim-better-whitespace",
    init = function()
      vim.g.better_whitespace_enabled = 1
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
    },
    config = function(_, opts)
      local noice = require("noice")
      noice.setup(opts)

      local map = function(mode, keys, command, desc)
        vim.keymap.set(mode, keys, command, { noremap = true, silent = true, expr = true, desc = desc })
      end

      map({ "n", "i", "s" }, "<C-f>", function()
        if not require("noice.lsp").scroll(4) then
          return "<c-f>"
        end
      end, "LSP Hover Scroll Down")

      map({ "n", "i", "s" }, "<C-b>", function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-b>"
        end
      end, "LSP Hover Scroll Up")
    end,


  }

}
