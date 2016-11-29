local setOmnifunc = function()
	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
end
vim.api.nvim_create_autocmd({"BufEnter"}, {
	buffer = 0,
	callback = setOmnifunc,
})

vim.keymap.set("n", "<C-B>", "<cmd>!task build<CR>", { noremap = true })

-- local format = vim.lsp.buf.formatting_sync({
-- 	filter = function(client) return client.name ~= "gopls" end,
-- })
--
-- vim.api.nvim_create_autocmd({"BufWritePre"}, {
--   pattern = {"*.go"},
--   callback = vim.lsp.buf.formatting_sync,
-- })
