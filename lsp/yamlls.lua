local yaml_companion = require('yaml-companion')
local setup_config = yaml_companion.setup()

-- Utility function for mapping keys
local map = function(mode, keys, command, desc, bufnr)
  vim.keymap.set(mode, keys, command, { noremap = true, silent = true, desc = desc, buffer = bufnr })
end

setup_config.on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    map('n', 'grf', vim.lsp.buf.format, "Format code (LSP)", bufnr)
  end

  map("n", "gd", vim.lsp.buf.definition, "Go to definition", bufnr)
  map("n", "K", "<CMD>Lspsaga hover_doc<CR>", "Show document of current word", bufnr)
end

setup_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

return setup_config
