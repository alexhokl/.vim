vim.api.nvim_set_keymap("n", "<F5>", "<cmd>SqlsExecuteQuery<CR>", { noremap = true })
vim.api.nvim_set_keymap("x", "<F5>", "<Plug>(sqls-execute-query)<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ds", "<cmd>SqlsSwitchConnection<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>SqlsSwitchDatabase<CR>", { noremap = true })

