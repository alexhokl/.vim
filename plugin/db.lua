local cmp = require 'cmp'

cmp.setup.filetype({ "sql" }, {
  sources = {
	{ name = 'vim-dadbod-completion' },
	{ name = 'buffer' },
  },
})

vim.g.db_ui_use_nerd_fonts = 1

