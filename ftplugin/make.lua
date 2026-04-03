local setLocal = function()
	vim.bo.tabstop = 2
	vim.bo.shiftwidth = 2
	vim.bo.softtabstop = 2
	vim.bo.expandtab = false
end

local group_id = vim.api.nvim_create_augroup("make", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
	group = group_id,
	buffer = 0,
	callback = setLocal,
})
