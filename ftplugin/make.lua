local setLocal = function()
	vim.bo.ts = 2
	vim.bo.sw = 2
	vim.bo.sts = 2
	vim.bo.noexpandtab = true
end

local group_id = vim.api.nvim_create_augroup("make", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
	group = group_id,
	buffer = 0,
	callback = setLocal,
})
