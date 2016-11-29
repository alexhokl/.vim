local defaultKeymapOpts = { noremap = true, silent = true }

vim.keymap.set("v", "<", function()
	vim.cmd("normal! <")
	vim.cmd("normal! gv")
end, defaultKeymapOpts)

vim.keymap.set("v", ">", function()
	vim.cmd("normal! >")
	vim.cmd("normal! gv")
end, defaultKeymapOpts)
