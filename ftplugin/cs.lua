vim.bo.ts = 4
vim.bo.sw = 4
vim.bo.sts = 4
vim.bo.expandtab = true

-- this is not correct as it affects the other buffers
-- autocmd should be used to get around this issue
-- where vim.bo.colorcolumn is not available
vim.o.colorcolumn = "100"

-- XML documentation
vim.keymap.set("n", "<leader>/", "<cmd>call AngelDoc#InsertXmlDoc()<CR>", { noremap = true })

-- build
vim.keymap.set("n", "<C-B>", "<cmd>!task build<CR>", { noremap = true })

