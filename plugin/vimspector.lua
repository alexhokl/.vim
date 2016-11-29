vim.g.vimspector_enable_mappings = "HUMAN"
vim.g.vimspector_install_gadgets = {"netcoredbg", "delve", "CodeLLDB"}
vim.g.vimspector_base_dir = ""

vim.api.nvim_set_keymap("n", "<leader>dc", "<Plug>VimspectorContinue<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F5>", "<Plug>VimspectorContinue<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>VimspectorReset<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>db", "<Plug>VimspectorToggleBreakpoint", { noremap = true })
vim.api.nvim_set_keymap("n", "<F9>", "<Plug>VimspectorToggleBreakpoint", { noremap = true })
vim.api.nvim_set_keymap("n", "<F10>", "<Plug>VimspectorStepOver", { noremap = true })
vim.api.nvim_set_keymap("n", "<F11>", "<Plug>VimspectorStepInto", { noremap = true })
vim.api.nvim_set_keymap("n", "<F12>", "<Plug>VimspectorStepOut", { noremap = true })

