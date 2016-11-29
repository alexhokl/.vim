require("todo-comments").setup();

vim.api.nvim_set_keymap('n', '<leader>todo', "<Cmd>TodoTelescope<CR>", {noremap = true})

