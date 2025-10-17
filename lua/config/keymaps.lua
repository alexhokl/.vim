-- lua/config/keymaps.lua

-- Utility function for mapping keys
local map = function(mode, keys, command, desc)
  vim.keymap.set(mode, keys, command, { noremap = true, silent = true, desc = desc })
end

-- Leader shortcuts (`,` is leader as set above)
-- (Additional leader mappings can be added here if needed)

-- Normal mode mappings
-- map("n", "<Space>", "zz", "Center screen on cursor") -- Press Space to center the screen at the cursor line
map("n", "<C-x>", ":bnext<CR>", "Next buffer")         -- Ctrl-X: switch to next buffer
map("n", "<C-z>", ":bprevious<CR>", "Previous buffer") -- Ctrl-Z: switch to previous buffer (repurposed, was suspend)

-- Multiple cursors (vim-visual-multi) will use <C-n> by default:
-- In normal mode <C-n> starts adding a cursor at current word, in visual it adds another selection.
-- We ensure <C-n> is not mapped to anything else, so no explicit mapping needed here (plugin handles it).

-- Telescope find/grep mappings (these will trigger lazy-loading of Telescope)
-- (Defined in plugin config via lazy keys, see plugins.lua)

-- Other convenient mappings
map("n", "Y", "y$", "Yank to end of line (like D/C)")      -- Make Y act like D (delete) and C (change)
map("n", "n", "nzzzv", "Next search result centered")      -- After search, center next match
map("n", "N", "Nzzzv", "Previous search result centered")  -- Center the screen on previous match
map("n", "J", "mzJ`z", "Join lines without moving cursor") -- Join lines and keep cursor in place
map("i", "jk", "<Esc>", "Exit insert mode quickly")        -- Press 'jk' fast in insert mode to exit to normal

-- Save and quit shortcuts
map("n", "<Leader>w", ":w<CR>", "Save file")
map("n", "<Leader>q", ":q<CR>", "Quit")

-- disable arrow keys in normal mode
map({ "n", "v" }, "<Up>", "<NOP>", "no-op")
map({ "n", "v" }, "<Down>", "<NOP>", "no-op")
map({ "n", "v" }, "<Left>", "<NOP>", "no-op")
map({ "n", "v" }, "<Right>", "<NOP>", "no-op")

-- disable page up/down
map({ "n", "i" }, "<PageUp>", "<NOP>", "no-op")
map({ "n", "i" }, "<PageDown>", "<NOP>", "no-op")

-- disable Q for ex-mode
map("n", "Q", "<NOP>", "no-op")

-- hide highlighted search results
map("n", "<leader><space>", function()
  vim.cmd("nohlsearch")
end, "Hide search highlights")

-- switch window
map("n", "<C-h>", "<C-w>h", "Jump to window on the left")
map("n", "<C-j>", "<C-w>j", "Jump to window below")
map("n", "<C-k>", "<C-w>k", "Jump to window above")
map("n", "<C-l>", "<C-w>l", "Jump to window on the right")

-- keys to resize splits
map("n", "<leader><Up>", "<CMD>resize +5<CR>", "Increase vertical size by 5")
map("n", "<leader><Down>", "<CMD>resize -5<CR>", "Decrease vertical size by 5")
map("n", "<leader><Left>", "<CMD>vertical resize -5<CR>", "Decrease horizontal size by 5")
map("n", "<leader><Right>", "<CMD>vertical resize +5<CR>", "Increase horizontal size by 5")

-- move visually selected blocks
map("x", "]e", ":move '>+1<CR>gv-gv", "Move block down")
map("x", "[e", ":move '<-2<CR>gv-gv", "Move block up")

-- change default behaviour of * and #
map("n", "*", ":let @/='\\v<' . expand('<cword>') . '>'<CR>:let v:searchforward=1<cr>n", "Find current word below")
map("n", "#", ":let @/='\\v<' . expand('<cword>') . '>'<CR>:let v:searchforward=0<cr>n", "Find current word above")

-- identation of a block
map("v", "<", function()
  vim.cmd("normal! <")
  vim.cmd("normal! gv")
end, "Decrease indentation of selected block")
map("v", ">", function()
  vim.cmd("normal! >")
  vim.cmd("normal! gv")
end, "Increase indentation of selected block")

-- folding
if vim.fn.has('folding') == 1 then
  map("n", "<leader>c0", function() vim.o.foldlevel = 0 end, "Collapses to level 1")
  map("n", "<leader>c1", function() vim.o.foldlevel = 1 end, "Collapses to level 2")
  map("n", "<leader>c2", function() vim.o.foldlevel = 2 end, "Collapses to level 3")
  map("n", "<leader>c3", function() vim.o.foldlevel = 3 end, "Collapses to level 4")
  map("n", "<leader>c4", function() vim.o.foldlevel = 4 end, "Collapses to level 5")
  map("n", "<leader>c5", function() vim.o.foldlevel = 5 end, "Collapses to level 6")
  map("n", "<leader>c9", function() vim.o.foldlevel = 99 end, "Expand all folds")
end

-- toggle relative number
local toggle_relative_number = function()
  -- get() is required as relativenumber is a table
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end
map('n', '<leader>rn', toggle_relative_number, "Toggle relative number")

-- show diagnostics in qickfix list
map("n", "<leader>tdq", vim.diagnostic.setqflist, "Show diagnostics in quickfix list")
