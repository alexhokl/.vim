return {

  {
    "dkarter/bullets.vim",
  },

  {
    "alexhokl/nvim-md-open-link",
    opts = {
      keymap = "gb",
    },
  },

  {
    "alexhokl/nvim-md-header-telescope-picker",
  },

  {
    "godlygeek/tabular",
  },

  {
    "plasticboy/vim-markdown",
  },

  {
    "alexhokl/nvim-md-toc",
    opts = {
      keymap = "<leader>rm",
    },
    config = function()
      local plugin = require("nvim-md-toc")
      plugin.setup({
        keymap = "<leader>rm",
      })

      -- Utility function for mapping keys
      local map = function(mode, keys, command, desc)
        vim.keymap.set(mode, keys, command, { noremap = true, silent = true, desc = desc })
      end

      local level_4 = function()
        plugin.refresh_toc(4)
      end
      map("n", "<leader>rrm", level_4, "Refresh table of contents")
    end
  },

  {
    "alexhokl/nvim-web-search",
    opts = {
      visual_mode_keymaps = {
        ["<leader>ji"] = "https://jisho.org/search/{}",
        ["<leader>jt"] = "https://translate.google.com/?sl=ja&tl=en&op=translate&text={}",
        ["<leader>go"] = "https://www.google.com/search?q={}",
      },
      normal_mode_keymaps = {
        ["<leader>ji"] = "https://jisho.org/search/{}",
      },
    },
  },

  {
    "alexhokl/nvim-kanji-to-hiragana",
    -- dir = "/nvim-kanji-to-hiragana/",
    ft = "markdown",
    opts = {},
  },

}
