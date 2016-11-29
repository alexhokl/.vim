local twilight = require("twilight")

twilight.setup {
}

vim.keymap.set('n', '<leader>ll', twilight.toggle, {noremap = true})
