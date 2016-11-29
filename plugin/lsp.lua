-- uncomment to enable debug logs
-- to view logs use `:lua vim.cmd('e'..vim.lsp.get_log_path())`
-- vim.lsp.set_log_level("debug")

local code_types = {
	Class = ' ',
	Color = ' ',
	Constant = ' ',
	Constructor = ' ',
	Enum = ' ',
	EnumMember = ' ',
	Event = ' ',
	Field = ' ',
	File = ' ',
	Folder = ' ',
	Function = ' ',
	Interface = ' ',
	Keyword = ' ',
	Method = ' ',
	Module = ' ',
	Operator = ' ',
	Property = ' ',
	Reference = ' ',
	Snippet = ' ',
	Struct = ' ',
	Text = ' ',
	TypeParameter = ' ',
	Unit = ' ',
	Value = ' ',
	Variable = ' ',
}

local format_on_save_filetypes = {
	"*.tf",
	"*.tfvars",
	"*.go",
	"*.rs",
	"*.lua",
	"*.py",
	"*.cs",
}

local enabled_lsp_clients = {
	"bashls",
	"clangd",
	"cmake",
	-- "csharp_ls",
	"docker_compose_language_service",
	"dockerls",
	"eslint",
	"gopls",
	"html",
	"jsonls",
	"ocamllsp",
	"omnisharp",
	"powershell_es",
	"pyright",
	"rust_analyzer",
	"lua_ls",
	"sqls",
	"terraformls",
	"tflint",
	"vimls",
	"yamlls",
}

require("mason").setup();
require("cmp_nvim_ultisnips").setup {}

local cmp = require 'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-a>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		-- enabling this will disable copilot
		-- ["<Tab>"] = cmp.mapping.confirm({
		-- 	behavior = cmp.ConfirmBehavior.Replace,
		-- 	select = true,
		-- }),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'vsnip',                keyword_length = 2 },
		-- { name = 'spell', keyword_length = 3 },
		{ name = 'treesitter' },
		{ name = 'path' },
		{ name = 'buffer',               keyword_length = 5 },
		{ name = 'cmdline' },
		{ name = 'git' },
		{ name = 'ultisnips' },
		{ name = 'vim-dadbod-completion' },
		-- { name = 'cmp_ai' }, -- promising but the suggestions are not that great yet
	},
	formatting = {
		format = function(entry, vim_item)
			-- Set `kind` to "$icon $kind".
			vim_item.kind = string.format('%s %s', code_types[vim_item.kind], vim_item.kind)
			vim_item.menu = ({
				nvim_lsp = "",
				treesitter = "",
				path = "",
				-- spell = "󰓆",
				buffer = "",
				Ollama = "🦙",
			})[entry.source.name]
			vim_item.maxwidth = 50
			return vim_item
		end,

		-- format = lspkind.cmp_format({
		-- 	with_text = true,
		-- 	menu = {
		-- 		nvim_lsp = "",
		-- 		treesitter = "",
		-- 		path = "",
		-- 		-- spell = "󰓆",
		-- 		buffer = "",
		-- 		Ollama = "🦙",
		-- 	},
		-- 	maxwidth = 50,
		-- })
	}
})

require("cmp_git").setup({
	-- defaults
	filetypes = { "gitcommit" },
	remote = "origin",
	git = {
		commits = {
			limit = 100,
		},
	},
	github = {
		issues = {
			filter = "all", -- assigned, created, mentioned, subscribed, all, repos
			limit = 100,
			state = "open", -- open, closed, all
		},
		mentions = {
			limit = 100,
		},
		pull_requests = {
			limit = 100,
			state = "open", -- open, closed, merged, all
		},
	},
})

require "lsp_signature".setup({
	bind = false,
})

-- enable formatting on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = format_on_save_filetypes,
	callback = function()
		vim.lsp.buf.format();
	end,
})

-- enable auto-completion
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

-- enable diagnostics to show in virtual lines (not virtual text)
vim.diagnostic.config({
	virtual_lines = {
		current_line = false,
	},
})

-- enable LSP clients
vim.lsp.enable(enabled_lsp_clients)
