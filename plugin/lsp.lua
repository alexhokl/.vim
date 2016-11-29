-- uncomment to enable debug logs
-- to view logs use `:lua vim.cmd('e'..vim.lsp.get_log_path())`
-- vim.lsp.set_log_level("debug")

require("mason").setup();
require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"clangd",
		"cmake",
		"dockerls",
		"eslint",
		"gopls",
		"html",
		"jsonls",
		"sumneko_lua",
		"omnisharp",
		"ocamllsp",
		"powershell_es",
		"pyright",
		"rust_analyzer",
		"terraformls",
		"vimls",
		"yamlls",
	},
});
-- local lsp_installer = require("nvim-lsp-installer")
-- local path = require "nvim-lsp-installer.core.path"

require("cmp_nvim_ultisnips").setup {}

local nvim_lsp = require('lspconfig')
local cmp = require 'cmp'
local lspkind = require('lspkind')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
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
		{ name = 'vsnip', keyword_length = 2 },
		-- { name = 'spell', keyword_length = 3 },
		{ name = 'treesitter' },
		{ name = 'path' },
		{ name = 'buffer', keyword_length = 3 },
		{ name = 'cmdline' },
		{ name = 'git' },
		{ name = 'ultisnips' },
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
			menu = {
				nvim_lsp = "",
				treesitter = "",
				path = "",
				-- spell = "暈",
				buffer = "﬘",
			},
			maxwidth = 50,
		})
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

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
	buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<leader>er', '<cmd>Telescope diagnostics<CR>', opts)

	if client.server_capabilities.documentFormattingProvider then
		buf_set_keymap('n', '<leader>ff', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
	end

	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_exec([[
			augroup lsp_document_highlight
				autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]], false)
	end
end

nvim_lsp.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})

nvim_lsp.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemas = {
				["https://bitbucket.org/atlassianlabs/atlascode/raw/main/resources/schemas/pipelines-schema.json"] = "bitbucket-pipelines.y*ml",
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				kubernetes = "*.y*ml",
			},
		}
	},
})

nvim_lsp.omnisharp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function(file, _)
		if file:sub(- #".csx") == ".csx" then
			return nvim_lsp.util.path.dirname(file)
		end
		local solution_path = nvim_lsp.util.root_pattern("*.sln")(file)
		if solution_path then
			return solution_path
		end
		return nvim_lsp.util.root_pattern("*.csproj")(file)
	end,
	-- uncomment to enable omnisharp/roslyn debug mode
	-- cmd = {
	--     "dotnet",
	--     path.concat { os.getenv("HOME"), ".local/share/nvim/lsp_servers/omnisharp/", "omnisharp", "OmniSharp.dll" },
	--     "--languageserver",
	-- 	"--loglevel",
	-- 	"Debug",
	--     "--hostPID",
	--     tostring(vim.fn.getpid()),
	-- },
})

nvim_lsp.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		rust_analyzer = {
			checkOnSave = "clippy",
		}
	},
})

nvim_lsp.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			}
		}
	},
})

nvim_lsp.sqls.setup {
	on_attach = function(client, bufnr)
		require('sqls').on_attach(client, bufnr)
	end,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	cmd = {
		"sqls",
		-- "-trace",
		-- "-log",
		-- "/tmp/sqls.log",
	},
}

nvim_lsp.dartls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}

require "lsp_signature".setup({
	bind = false,
})
