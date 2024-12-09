-- uncomment to enable debug logs
-- to view logs use `:lua vim.cmd('e'..vim.lsp.get_log_path())`
-- vim.lsp.set_log_level("debug")

require("mason").setup();
require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"clangd",
		"cmake",
		"csharp_ls",
		"docker_compose_language_service",
		"dockerls",
		"eslint",
		"gopls",
		"html",
		"jsonls",
		"ocamllsp",
		-- "omnisharp",
		"powershell_es",
		"pyright",
		"rust_analyzer",
		"lua_ls",
		-- "sqls",
		-- "sqlls",
		-- "terraformls",
		"tflint",
		"vimls",
		"yamlls",
	},
	automatic_installation = true,
});
-- local lsp_installer = require("nvim-lsp-installer")
-- local path = require "nvim-lsp-installer.core.path"

require("cmp_nvim_ultisnips").setup {}

local nvim_lsp = require('lspconfig')
local cmp = require 'cmp'
local lspkind = require('lspkind')
local mason_config = require("mason-lspconfig")
local nvim_lsp_configs = require("lspconfig.configs")

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
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				nvim_lsp = "",
				treesitter = "",
				path = "",
				-- spell = "󰓆",
				buffer = "",
				Ollama = "🦙",
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

		-- format the current buffer on save
		vim.api.nvim_create_autocmd('BufWritePre', {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
			end,
		})
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

mason_config.setup_handlers {
	-- default handler
	function(server_name)
		nvim_lsp[server_name].setup {
			on_attach = on_attach,
			capabilities = capabilities,
		}
	end,
	['gopls'] = function()
		nvim_lsp.gopls.setup {
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
		}
	end,
	['yamlls'] = function()
		nvim_lsp.yamlls.setup(require("yaml-companion").setup())
	end,
	-- ['omnisharp'] = function()
	-- 	nvim_lsp.omnisharp.setup {
	-- 		on_attach = on_attach,
	-- 		capabilities = capabilities,
	-- 		root_dir = function(file, _)
	-- 			if file:sub(- #".csx") == ".csx" then
	-- 				return nvim_lsp.util.path.dirname(file)
	-- 			end
	-- 			local solution_path = nvim_lsp.util.root_pattern("*.sln")(file)
	-- 			if solution_path then
	-- 				return solution_path
	-- 			end
	-- 			return nvim_lsp.util.root_pattern("*.csproj")(file)
	-- 		end,
	-- 		-- uncomment to enable omnisharp/roslyn debug mode
	-- 		-- cmd = {
	-- 		--     "dotnet",
	-- 		--     path.concat { os.getenv("HOME"), ".local/share/nvim/lsp_servers/omnisharp/", "omnisharp", "OmniSharp.dll" },
	-- 		--     "--languageserver",
	-- 		-- 	"--loglevel",
	-- 		-- 	"Debug",
	-- 		--     "--hostPID",
	-- 		--     tostring(vim.fn.getpid()),
	-- 		-- },
	-- 	}
	-- end,
	['csharp_ls'] = function()
		nvim_lsp.csharp_ls.setup {
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
			handlers = {
				["textDocument/definition"] = require('csharpls_extended').handler,
			},
		}
	end,
	['rust_analyzer'] = function()
		nvim_lsp.rust_analyzer.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				rust_analyzer = {
					checkOnSave = "clippy",
				}
			},
		}
	end,
	['lua_ls'] = function()
		nvim_lsp.lua_ls.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }
					}
				}
			},
		}
	end,
	-- ['sqlls'] = function()
	-- 	nvim_lsp.sqlls.setup{
	-- 		on_attach = on_attach,
	-- 		capabilities = capabilities,
	-- 		root_dir = function()
	-- 			return vim.loop.cwd()
	-- 		end,
	-- 		cmd = { 'sql-language-server', 'up', '--method', 'stdio', '--debug' },
	-- 	}
	-- end,
}

nvim_lsp_configs.sql = {
	default_config = {
		cmd = { 'sqls' },
		filetypes = { 'sql', 'mysql' },
		root_dir = require('lspconfig.util').root_pattern 'config.yml',
		single_file_support = true,
		settings = {},
	}
}
nvim_lsp.sql.setup {
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

require "lsp_signature".setup({
	bind = false,
})
