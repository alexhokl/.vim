require("twilight").setup {
}

vim.api.nvim_set_keymap('n', '<leader>ll', "<Cmd>lua require('twilight').toggle()<CR>", {noremap = true})
