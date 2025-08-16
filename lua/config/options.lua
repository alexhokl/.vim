-- lua/config/options.lua

-- Neovim UI Settings
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers for easy line navigation
vim.opt.cursorline = true     -- Highlight the current line
vim.opt.signcolumn = "yes"    -- Always show sign column (for gitsigns, LSP) to avoid text shifting
vim.opt.colorcolumn = "80"    -- Highlight column 80 as a guideline (e.g. for code width)

-- Indentation and Tabs
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 2     -- Shift indent by 2 spaces (for autoindent, <<, >>)
vim.opt.tabstop = 2        -- A tab counts as 2 spaces
vim.opt.smartindent = true -- Smart indentation on new lines
vim.opt.autoindent = true  -- Maintain indent of current line on new lines

-- Search Settings
vim.opt.ignorecase = true -- Case-insensitive search by default...
vim.opt.smartcase = true  -- ... but case-sensitive if query contains capital letters
vim.opt.incsearch = true  -- Incremental search (find as you type)
vim.opt.hlsearch = true   -- Highlight search matches

-- Performance and UX
vim.opt.updatetime = 300     -- Faster update for CursorHold (for gitgutter or diagnostics)
vim.opt.timeoutlen = 500     -- Shorten key sequence timeout for a snappier experience
vim.opt.splitright = true    -- Open vertical splits to the right
vim.opt.splitbelow = true    -- Open horizontal splits below
vim.opt.scrolloff = 8        -- Keep 8 lines above/below cursor when scrolling
vim.opt.termguicolors = true -- True color support

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all yank, delete, paste, etc.

-- Disable backup, swap and restore (handled by git/Nix, and to avoid swap files)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true                              -- Enable persistent undo
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo" -- set undo file directory

-- Misc
vim.opt.mouse = "a"   -- Enable mouse support in all modes
vim.opt.hidden = true -- Allow switching buffers without saving

--further customisation from jess
vim.opt.completeopt = { "longest", "menuone", "preview" }
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·" }
vim.opt.suffixesadd = { ".cs", ".csproj", ".go", ".md" }
vim.opt.inccommand = "nosplit"
vim.opt.spelllang = { "en_gb" }
vim.opt.makeprg = 'task'

if vim.fn.has('folding') == 1 then
  vim.o.foldmethod = 'expr'
  vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
end
