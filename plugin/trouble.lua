local trouble = require("trouble")
local todo = require("todo-comments")

trouble.setup{}
todo.setup{}

local opts = {
  silent = true,
  noremap = true,
}

-- vim.keymap.set("n", "<leader>ed", function() trouble.open("document_diagnostics") end, opts)
-- vim.keymap.set("n", "<leader>er", function() trouble.open("workspace_diagnostics") end, opts)
vim.keymap.set("n", "<leader>gr", "<cmd>Trouble lsp_references toggle<cr>", opts)
vim.keymap.set("n", "<leader>ee", "<cmd>Trouble diagnostics toggle<cr>", opts)
vim.keymap.set("n", "<leader>et", "<cmd>Trouble todo toggle<cr>", opts)

vim.keymap.set("n", "<leader>todo", ':TodoTelescope<CR>', opts)
