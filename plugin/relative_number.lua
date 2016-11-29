local defaultOptions = {
	noremap = true,
	silent = true,
}

local toggle_relative_number = function()
	-- get() is required as relativenumber is a table
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end

vim.keymap.set('n', '<leader>rn', toggle_relative_number, defaultOptions)
