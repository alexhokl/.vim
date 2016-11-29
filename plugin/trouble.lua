local trouble = require("trouble")
local todo = require("todo-comments")

trouble.setup {
}
todo.setup {}

local opts = {
	silent = true,
	noremap = true,
}

local toggle_diagnostics = function()
	trouble.toggle({
		mode = 'diagnostics',
		focus = true,
	})
end

local toggle_todo = function()
	trouble.toggle({
		mode = 'todo',
		focus = true,
	})
end

local toggle_references = function()
	trouble.toggle({
		mode = 'lsp_references',
		focus = true,
	})
end

vim.keymap.set("n", "<leader>tr", toggle_references, opts)
vim.keymap.set("n", "<leader>td", toggle_diagnostics, opts)
vim.keymap.set("n", "<leader>tt", toggle_todo, opts)
