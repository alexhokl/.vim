require("todo-comments").setup();

vim.keymap.set("n", "<leader>todo", ':TodoTelescope<CR>', { noremap = true, silent = true })

