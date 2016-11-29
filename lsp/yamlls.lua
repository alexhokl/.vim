local yaml_companion = require('yaml-companion')
local setup_config = yaml_companion.setup()

setup_config.on_attach = function(client, bufnr)
	local default_options = {
		noremap = true,
		silent = true,
		buffer = bufnr
	}
	if client.server_capabilities.documentFormattingProvider then
		vim.keymap.set('n', 'grf', vim.lsp.buf.format, default_options)
	end
end

setup_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

return setup_config
