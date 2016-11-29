return {
	on_attach = function(client, bufnr)
		local default_keymap_options = { noremap = true, silent = true }

		vim.keymap.set("n", "<leader>ds", "<cmd>SqlsSwitchConnection<CR>", default_keymap_options)
		vim.keymap.set("n", "<leader>dd", "<cmd>SqlsSwitchDatabase<CR>", default_keymap_options)
		vim.keymap.set("n", "<F5>", "<cmd>SqlsExecuteQuery<CR>", default_keymap_options)
		vim.keymap.set("x", "<F5>", "<Plug>(sqls-execute-query)<CR>", default_keymap_options)

		require('sqls').on_attach(client, bufnr)
	end,
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	flags = {
		debounce_text_changes = 150,
	},
	cmd = {
		"sqls",
		-- "-trace",
		-- "-log",
		-- "/tmp/sqls.log",
	},
}
