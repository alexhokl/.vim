return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  on_attach = function(client, bufnr)
    -- Utility function for mapping keys
    local map = function(mode, keys, command, desc, buff)
      vim.keymap.set(mode, keys, command, { noremap = true, silent = true, desc = desc, buffer = buff })
    end

    if client.server_capabilities.documentFormattingProvider then
      map('n', 'grf', vim.lsp.buf.format, "Format code (LSP)", bufnr)
    end

    map("n", "gd", vim.lsp.buf.definition, "Go to definition", bufnr)
    map("n", "K", "<CMD>Lspsaga hover_doc<CR>", "Show document of current word", bufnr)
    map("n", "[d", "<CMD>Lspsaga diagnostic_jump_prev<CR>", "Jump to error above", bufnr)
    map("n", "]d", "<CMD>Lspsaga diagnostic_jump_next<CR>", "Jump to error below", bufnr)
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}
