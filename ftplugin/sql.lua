vim.api.nvim_set_keymap("n", "<F5>", "<cmd>SqlsExecuteQuery<CR>", { noremap = true })
vim.api.nvim_set_keymap("x", "<F5>", "<Plug>(sqls-execute-query)<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-T>", "<cmd>SqlsSwitchConnection<CR>", { noremap = true })

