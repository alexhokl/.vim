local plugin = require("nvim-md-open-link")
plugin.setup()

local function refreshMarkdownTopics()
	vim.cmd('/___')
	vim.cmd('normal! kVggddd')
	vim.cmd(':r !markdown-toc --maxdepth 3 %')
	vim.cmd('normal! ppDggdd')
end

vim.keymap.set("n", "<leader>rm", refreshMarkdownTopics, { noremap = true, silent = true })
