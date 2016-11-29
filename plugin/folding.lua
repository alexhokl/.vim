if vim.fn.has('folding') == 1 then
	vim.api.nvim_set_option('foldmethod', 'indent')
	vim.api.nvim_set_option('foldlevelstart', 99)

	vim.api.nvim_set_keymap('n', '<leader>c0', "<Cmd>set foldlevel=0<CR>", {noremap = true})
	vim.api.nvim_set_keymap('n', '<leader>c1', "<Cmd>set foldlevel=1<CR>", {noremap = true})
	vim.api.nvim_set_keymap('n', '<leader>c2', "<Cmd>set foldlevel=2<CR>", {noremap = true})
	vim.api.nvim_set_keymap('n', '<leader>c3', "<Cmd>set foldlevel=3<CR>", {noremap = true})
	vim.api.nvim_set_keymap('n', '<leader>c4', "<Cmd>set foldlevel=4<CR>", {noremap = true})
	vim.api.nvim_set_keymap('n', '<leader>c5', "<Cmd>set foldlevel=5<CR>", {noremap = true})
	vim.api.nvim_set_keymap('n', '<leader>c9', "<Cmd>set foldlevel=99<CR>", {noremap = true})
end
