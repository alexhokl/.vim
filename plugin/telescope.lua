local default_opts = { noremap = true, silent = true }
local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, default_opts)
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, default_opts)
vim.keymap.set('n', '<C-t>', telescope_builtin.live_grep, default_opts)
vim.keymap.set('n', '<leader>F', telescope_builtin.grep_string, default_opts)
vim.keymap.set('n', '<leader>m', telescope_builtin.keymaps, default_opts)
vim.keymap.set('n', '<leader>j', telescope_builtin.jumplist, default_opts)
