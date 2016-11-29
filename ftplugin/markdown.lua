local plugin = require("nvim-md-open-link")
plugin.setup()

local function refreshMarkdownTopics(depth)
	vim.cmd('/___')
	vim.cmd('normal! kVggddd')
	vim.cmd(':r !markdown-toc --maxdepth ' .. depth .. ' %')
	vim.cmd('normal! ppDggdd')
end

local function refreshMarkdownTopics3Levels()
	refreshMarkdownTopics(3)
end

local function refreshMarkdownTopics4Levels()
	refreshMarkdownTopics(4)
end

local defaultKeymapOpts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>rm", refreshMarkdownTopics3Levels, defaultKeymapOpts)
vim.keymap.set("n", "<leader>rrm", refreshMarkdownTopics4Levels, defaultKeymapOpts)

-- add a code block
vim.keymap.set("n", "<leader>co", function()
	vim.cmd('normal! I```')
	vim.cmd('normal! o```')
	vim.cmd('normal! k')
	vim.cmd 'startinsert!' -- ! to insert at the end of the line
end, defaultKeymapOpts)

-- make visual selection as a code block
vim.keymap.set("x", "<leader>co", function()
	vim.cmd('normal! dO```')
	vim.cmd('normal! o```')
	vim.cmd('normal! Pk')
	vim.cmd 'startinsert!' -- ! to insert at the end of the line
end, defaultKeymapOpts)

-- surround a character with tag "kbd"
vim.keymap.set("n", "<leader>k", function()
	vim.cmd('normal! i<kbd>')
	vim.cmd('normal! la</kbd>')
	vim.cmd('normal! l')
end, defaultKeymapOpts)

vim.keymap.set("x", "<leader>t", function()
	vim.cmd(':Tabularize /|')
end, defaultKeymapOpts)

local function removeExistingMarkdownHeader()
	local line = vim.api.nvim_get_current_line()
	-- if line starts with "#", remove it
	if line:sub(1, 1) == "#" then
		vim.cmd('normal! 0')
		vim.cmd('normal! daw')
	end
end

local function addMarkdownHeader(level)
	local line = vim.api.nvim_get_current_line()
	local hash_str = string.rep("#", level)
	vim.api.nvim_set_current_line(hash_str .. " " .. line)
end

for i = 1, 6 do
	vim.keymap.set("n", "<leader>h" .. i, function()
		removeExistingMarkdownHeader()
		addMarkdownHeader(i)
	end, defaultKeymapOpts)
end

vim.g.tex_conceal = ""
vim.g.vim_markdown_math = 1
vim.g.vim_markdown_new_list_item_indent = 2 -- default: 4
vim.g.vim_markdown_folding_level = 5

-- " syntax highlight
vim.g.vim_markdown_fenced_languages = { 'csharp=cs' }

vim.g.vim_markdown_strikethrough = 1

-- " ========= vim-markdown ==================
-- " disable folding
vim.g.vim_markdown_folding_disabled = 0

-- " Allow for the TOC window to auto-fit when it's possible for it to shrink.
-- " It never increases its default size (half screen), it only shrinks.
vim.g.vim_markdown_toc_autofit = 1

-- " Disable conceal
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0

-- " Allow the ge command to follow named anchors in links of the form
-- " file#anchor or just #anchor, where file may omit the .md extension as usual
vim.g.vim_markdown_follow_anchor = 1

-- " highlight frontmatter
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_toml_frontmatter = 1
vim.g.vim_markdown_json_frontmatter = 1

-- bullets.vim
vim.g.bullets_set_mappings = 0
vim.g.bullets_auto_indent_after_colon = 0
vim.keymap.set("n", "<leader>>", "<Plug>(bullets-demote)<cr>", defaultKeymapOpts)
vim.keymap.set("v", "<leader>>", "<Plug>(bullets-demote)<cr>", defaultKeymapOpts)
vim.keymap.set("n", "<leader><", "<Plug>(bullets-promote)<cr>", defaultKeymapOpts)
vim.keymap.set("v", "<leader><", "<Plug>(bullets-promote)<cr>", defaultKeymapOpts)
