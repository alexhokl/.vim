-- Set <Leader> to comma (`,`), matching the old Vim config leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Load core settings and mappings
require("config.options")  -- vim options (replaces vim-sensible defaults)
require("config.keymaps")  -- global keymaps (replaces old mappings)
require("config.autocmds") -- autocmds (replaces old autocommands)
require("config.filetypes") -- filetype settings (replaces old filetype settings)

-- Bootstrap lazy.nvim plugin manager if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use lazy.nvim to set up plugins (defined in lua/plugins.lua)
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- Import plugins from lua/plugins.lua
    { import = "plugin" },
  }
}, {
  ui = { border = "rounded" },
  performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "netrwPlugin" } } },
  git = {
    throttle = {
      enabled = true,
      rate = 2,
      duration = 5000, -- in milliseconds
    },
  },
})

require("config.format") -- auto-formatting with Conform.nvim
