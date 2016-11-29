local setLocal = function()
	vim.api.nvim_buf_set_option("ts", 2)
	vim.api.nvim_buf_set_option("sw", 2)
	vim.api.nvim_buf_set_option("sts", 2)
	vim.api.nvim_buf_set_option("noexpandtab", true)
end

local group_id = vim.api.nvim_create_augroup("make", { clear = true })

vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
	group = group_id,
	buffer = 0,
	callback = setLocal,
})
