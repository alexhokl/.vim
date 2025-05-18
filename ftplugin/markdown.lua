-- Utility function for mapping keys
local map = function(mode, keys, command, desc)
  vim.keymap.set(mode, keys, command, { noremap = true, silent = true, desc = desc })
end

-- add a code block
map("n", "<leader>co", function()
  vim.cmd('normal! I```')
  vim.cmd('normal! o```')
  vim.cmd('normal! k')
  vim.cmd 'startinsert!' -- ! to insert at the end of the line
end, "Insert code block")

-- make visual selection as a code block
map("x", "<leader>co", function()
  vim.cmd('normal! dO```')
  vim.cmd('normal! o```')
  vim.cmd('normal! Pk')
  vim.cmd 'startinsert!' -- ! to insert at the end of the line
end, "Wrap in code block")

-- surround a character with tag "kbd"
map("n", "<leader>k", function()
  vim.cmd('normal! i<kbd>')
  vim.cmd('normal! la</kbd>')
  vim.cmd('normal! l')
end, "Insert markdown of kbd")

map("x", "<leader>t", function()
  vim.cmd(':Tabularize /|')
end, "Format markdown table")

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
  map("n", "<leader>h" .. i, function()
    removeExistingMarkdownHeader()
    addMarkdownHeader(i)
  end, "Set markdown header level " .. i)
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

vim.bo.textwidth = 80

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
map("n", "<leader>>", "<Plug>(bullets-demote)<cr>", "Increase indent of a bullet")
map("v", "<leader>>", "<Plug>(bullets-demote)<cr>", "Increase indent of a bullet")
map("n", "<leader><", "<Plug>(bullets-promote)<cr>", "Decrease indent of a bullet")
map("v", "<leader><", "<Plug>(bullets-promote)<cr>", "Decrease indent of a bullet")
