require("trouble").setup{}

local opts = {
  silent = true,
  noremap = true,
}

vim.api.nvim_set_keymap("n", "<leader>ed", "<cmd>Trouble document_diagnostics<CR>", opts)
