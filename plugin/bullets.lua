vim.g.bullets_set_mappings = 0
vim.g.bullets_auto_indent_after_colon = 0

local defaultKeymapOpts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>>", "<Plug>(bullets-demote)<cr>", defaultKeymapOpts)
vim.keymap.set("v", "<leader>>", "<Plug>(bullets-demote)<cr>", defaultKeymapOpts)
vim.keymap.set("n", "<leader><", "<Plug>(bullets-promote)<cr>", defaultKeymapOpts)
vim.keymap.set("v", "<leader><", "<Plug>(bullets-promote)<cr>", defaultKeymapOpts)
