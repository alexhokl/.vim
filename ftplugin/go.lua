local setOmnifunc = function()
	vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
end
vim.api.nvim_create_autocmd({"BufEnter"}, {
	buffer = 0,
	callback = setOmnifunc,
})

vim.api.nvim_buf_set_keymap(0, "n", "<C-B>", "<cmd>!make install<CR>", { noremap = true })

-- local format = vim.lsp.buf.formatting_sync({
-- 	filter = function(client) return client.name ~= "gopls" end,
-- })
--
-- vim.api.nvim_create_autocmd({"BufWritePre"}, {
--   pattern = {"*.go"},
--   callback = vim.lsp.buf.formatting_sync,
-- })