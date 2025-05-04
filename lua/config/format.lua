-- lua/config/format.lua
-- 𝗔𝘂𝘁𝗼-𝗳𝗼𝗿𝗺𝗮𝘁 𝗼𝗻 𝗦𝗮𝘃𝗲  –  Conform.nvim wraps every tool behind one API
-- https://github.com/stevearc/conform.nvim
require("conform").setup({
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		go = { "goimports", "gofumpt" }, -- fallback chain
		javascript = { "biome-organize-imports", "biome" },
		json = { "jq" },
		jsx = { "biome-organize-imports", "biome" },
		lua = { "stylua" },               -- needs stylua in $PATH
		python = { "ruff_format", "ruff_fix" }, -- needs ruff in $PATH
		nix = { "alejandra" },
		markdown = { "mdformat" },
		rust = { "rustfmt", lsp_format = "fallback" },
		tsx = { "biome-organize-imports", "biome" },
		typescript = { "biome-organize-imports", "biome" },
		yaml = { "yamlfmt" },
		-- Use the "_" filetype to run formatters on filetypes that don't
		-- have other formatters configured.
		["_"] = { "trim_whitespace" },
	},
	-- extra-exe overrides (binary names differ on Nix sometimes):
	formatters = {
		alejandra = { command = "alejandra", args = { "--quiet", "-" } },
	},
})
