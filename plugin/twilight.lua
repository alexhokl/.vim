local twilight = require("twilight")

twilight.setup {
	context = 5, -- amount of lines we will try to show around the current line
}

vim.keymap.set('n', '<leader>ll', twilight.toggle, {noremap = true})
