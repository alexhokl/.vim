return {
  on_attach = function(client, bufnr)
    local ok, sqls = pcall(require, "sqls")
    if not ok then
      vim.notify("Failed to load sqls.nvim: " .. sqls, vim.log.levels.WARN)
    else
      sqls.on_attach(client, bufnr)
    end

    -- Utility function for mapping keys
    local map = function(mode, keys, command, desc, buff)
      vim.keymap.set(mode, keys, command, { noremap = true, silent = true, desc = desc, buf = buff })
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
  cmd = {
    vim.fn.expand("$HOME/git/bin/sqls"),
    -- "-trace",
    -- "-log",
    -- "/tmp/sqls.log",
  },
}
