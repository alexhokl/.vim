-- Set <Leader> to comma (`,`), matching the old Vim config leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Load core settings and mappings
require("config.options") -- vim options (replaces vim-sensible defaults)
require("config.keymaps") -- global keymaps (replaces old mappings)
require("config.autocmds") -- autocmds (replaces old autocommands)
require("config.filetypes") -- filetype settings (replaces old filetype settings)

--- Fetch plugins over HTTPS, bypassing the global SSH insteadOf ------------
-- Global git config rewrites https://github.com/ to SSH (gpg-agent/YubiKey),
-- which cannot handle lazy's ~80 parallel fetches. Plugins are public, so
-- lazy uses a "lazy-gh:" prefix that git maps back to plain HTTPS. Only URLs
-- starting with "lazy-gh:" are affected; other git usage is unchanged.
vim.env.GIT_CONFIG_COUNT = "1"
vim.env.GIT_CONFIG_KEY_0 = "url.https://github.com/.insteadOf"
vim.env.GIT_CONFIG_VALUE_0 = "lazy-gh:"

-- Bootstrap lazy.nvim plugin manager if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"lazy-gh:folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Use lazy.nvim to set up plugins (defined in lua/plugins.lua)
-- Note: options must live in this single table; when the first argument has a
-- `spec` key, lazy ignores any second (opts) argument.
require("lazy").setup({
	spec = {
		{ import = "plugins" }, -- Import plugins from lua/plugins.lua
		{ import = "plugin" },
	},
	ui = { border = "rounded" },
	performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "netrwPlugin" } } },
	-- cap concurrent tasks to avoid bursts of anonymous HTTPS fetches
	concurrency = 8,
	git = {
		url_format = "lazy-gh:%s.git", -- see GIT_CONFIG_* above
	},
})

require("config.format") -- auto-formatting with Conform.nvim
