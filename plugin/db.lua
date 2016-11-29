local cmp = require 'cmp'

local opts = {
  silent = true,
  noremap = true,
}

cmp.setup.filetype({ "sql" }, {
  sources = {
	{ name = 'vim-dadbod-completion' },
	{ name = 'buffer' },
  },
})

vim.g.db_ui_use_nerd_fonts = 1

vim.g.db_ui_table_helpers = {
	postgresql = {
		Count = 'SELECT COUNT(*) FROM "{table}"',
	},
	sqlserver = {
		Count = 'SELECT COUNT(*) FROM "{table}"',
	},
	sqlite = {
		Count = 'SELECT COUNT(*) FROM "{table}"',
	},
}

vim.keymap.set("n", "<leader>dbe", ':e ~/.local/share/db_ui/connections.json<CR>', opts)
vim.keymap.set("n", "<leader>dbc", ':DBUIToggle<CR>', opts)

