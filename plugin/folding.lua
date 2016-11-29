local defaultOpts = { noremap = true, silent = true }

if vim.fn.has('folding') == 1 then
	vim.o.foldmethod = 'indent'
	vim.o.foldlevel = 99
	vim.o.foldlevelstart = 99

	vim.keymap.set("n", "<leader>c0", function () vim.o.foldlevel=0 end, defaultOpts)
	vim.keymap.set("n", "<leader>c1", function () vim.o.foldlevel=1 end, defaultOpts)
	vim.keymap.set("n", "<leader>c2", function () vim.o.foldlevel=2 end, defaultOpts)
	vim.keymap.set("n", "<leader>c3", function () vim.o.foldlevel=3 end, defaultOpts)
	vim.keymap.set("n", "<leader>c4", function () vim.o.foldlevel=4 end, defaultOpts)
	vim.keymap.set("n", "<leader>c5", function () vim.o.foldlevel=5 end, defaultOpts)
	vim.keymap.set("n", "<leader>c9", function () vim.o.foldlevel=99 end, defaultOpts)
end
