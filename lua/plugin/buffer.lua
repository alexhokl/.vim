return {

  {
    "mhinz/vim-sayonara",
  },

  {
    "axkirillov/hbac.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local hbac = require("hbac")
      local actions = require("hbac.telescope.actions")
      local telescope = require("telescope")
      local default_keymap_options = { noremap = true, silent = true }

      telescope.load_extension('hbac')

      hbac.setup({
        autoclose                  = false, -- set autoclose to false if you want to close manually
        threshold                  = 10,    -- hbac will start closing unedited buffers once that number is reached
        close_command              = function(bufnr)
          vim.api.nvim_buf_delete(bufnr, {})
        end,
        close_buffers_with_windows = false, -- hbac will close buffers with associated windows if this option is `true`
        telescope                  = {
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
              ["<C-x>"] = actions.close_unpinned,
              ["<C-CR>"] = actions.toggle_pin,
            },
            n = {
              ["<C-d>"] = actions.delete_buffer,
              ["<C-x>"] = actions.close_unpinned,
              ["<C-CR>"] = actions.toggle_pin,
            },
          },
        },
      })

      vim.keymap.set('n', '<leader>b', telescope.extensions.hbac.buffers, default_keymap_options)
      vim.keymap.set('n', '<C-CR>', hbac.toggle_pin, default_keymap_options)
    end,
  },

}
