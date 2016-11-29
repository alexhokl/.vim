return {
	settings = {
		rust_analyzer = {
			checkOnSave = "clippy",
		}
	},
	on_attach = function(client, bufnr)
		local default_options = {
			noremap = true,
			silent = true,
			buffer = bufnr
		}
		if client.server_capabilities.documentFormattingProvider then
			vim.keymap.set('n', 'grf', vim.lsp.buf.format, default_options)
		end
	end,
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
}
