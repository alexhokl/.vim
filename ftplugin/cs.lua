vim.api.nvim_buf_set_option(0, "ts", 4)
vim.api.nvim_buf_set_option(0, "sw", 4)
vim.api.nvim_buf_set_option(0, "sts", 4)
vim.api.nvim_buf_set_option(0, "expandtab", true)

-- this is not correct as it affects the other buffers
-- autocmd should be used to get around this issue
-- where nvim_buf_set_option is not available for colorcolumn
vim.api.nvim_set_option("colorcolumn", "100")

-- XML documentation
vim.api.nvim_buf_set_keymap(0, "n", "<leader>/", "<cmd>call AngelDoc#InsertXmlDoc()<CR>", { noremap = true })

vim.api.nvim_buf_set_keymap(0, "n", "<C-B>", "<cmd>!make build<CR>", { noremap = true })

