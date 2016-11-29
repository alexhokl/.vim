local default_opts = { noremap = true, silent = true }

vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = vim.lsp.buf.format,
})

vim.keymap.set('n', '<leader>ff', ':!terraform fmt -recursive<CR>', default_opts)
