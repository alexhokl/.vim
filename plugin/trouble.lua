local trouble = require("trouble")

trouble.setup{}

local opts = {
  silent = true,
  noremap = true,
}

vim.keymap.set("n", "<leader>ed", function() trouble.open("document_diagnostics") end, opts)
vim.keymap.set("n", "<leader>er", function() trouble.open("workspace_diagnostics") end, opts)
vim.keymap.set("n", "<leader>gr", function() trouble.open("lsp_references") end, opts)
vim.keymap.set("n", "<leader>ee", trouble.toggle, opts)

