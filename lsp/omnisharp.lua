return {
	-- uncomment to enable omnisharp/roslyn debug mode
	-- cmd = {
	--     "dotnet",
	--     path.concat { os.getenv("HOME"), ".local/share/nvim/lsp_servers/omnisharp/", "omnisharp", "OmniSharp.dll" },
	--     "--languageserver",
	-- 	"--loglevel",
	-- 	"Debug",
	--     "--hostPID",
	--     tostring(vim.fn.getpid()),
	-- },
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
