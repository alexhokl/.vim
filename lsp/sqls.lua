return {
  filetypes = { "sql", "mysql", "plsql" },
  root_markers = { ".git" },
  on_attach = function(client, bufnr)
    -- nanotee/sqls.nvim no longer exposes a `sqls` Lua module; it ships its
    -- own `lsp/sqls.lua` (on_attach, commands, ...) that Neovim's native LSP
    -- config system would normally auto-discover from the plugin's runtime
    -- path. Since this file overrides it, load the plugin's default config
    -- directly and call its on_attach to keep commands like
    -- :SqlsExecuteQuery working.
    local lazy_ok, lazy_config = pcall(require, "lazy.core.config")
    if lazy_ok and lazy_config.plugins["sqls.nvim"] then
      local sqls_lsp_file = lazy_config.plugins["sqls.nvim"].dir .. "/lsp/sqls.lua"
      local ok, sqls_default_config = pcall(dofile, sqls_lsp_file)
      if ok and sqls_default_config.on_attach then
        sqls_default_config.on_attach(client, bufnr)
      else
        vim.notify("Failed to load sqls.nvim default config: " .. tostring(sqls_default_config), vim.log.levels.WARN)
      end
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
