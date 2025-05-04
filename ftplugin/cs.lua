vim.bo.ts = 4
vim.bo.sw = 4
vim.bo.sts = 4
vim.bo.expandtab = true

-- set colourcolumn for cs files on file open
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.cs",
	callback = function()
		vim.opt_local.colorcolumn = "100"
	end,
})

-- set errorformat for parsing output from dotnet build
vim.opt.errorformat = '%f(%l\\,%c):%m'
