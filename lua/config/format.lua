-- lua/config/format.lua
-- ����-������ �� ����  –  Conform.nvim wraps every tool behind one API
-- https://github.com/stevearc/conform.nvim
require("conform").setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    cs = { lsp_format = "prefer" }, -- roslyn LSP handles formatting
    d2 = { "d2" },
    go = { "goimports", "gofumpt" }, -- fallback chain
    hcl = { "terraform_fmt" },
    javascript = { "biome-organize-imports", "biome" },
    json = { "jq" },
    jsx = { "biome-organize-imports", "biome" },
    lua = { "stylua" },                     -- needs stylua in $PATH
    python = { "ruff_format", "ruff_fix" }, -- needs ruff in $PATH
    nix = { "alejandra" },
    -- markdown = { "mdformat" },
    rust = { "rustfmt", lsp_format = "fallback" },
    terraform = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
    toml = { "taplo" },
    tsx = { "biome-organize-imports", "biome" },
    typescript = { "biome-organize-imports", "biome" },
    yaml = { "yamlfmt" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },
  -- extra-exe overrides: absolute paths so Neovim finds them regardless of $PATH
  formatters = {
    alejandra = { command = "/opt/homebrew/bin/alejandra", args = { "--quiet", "-" } },
    biome = { command = "/opt/homebrew/bin/biome" },
    d2 = { command = "/opt/homebrew/bin/d2" },
    gofumpt = { command = vim.uv.os_homedir() .. "/git/bin/gofumpt" },
    ruff = { command = "/opt/homebrew/bin/ruff" },
    stylua = { command = "/opt/homebrew/bin/stylua" },
    taplo = { command = "/opt/homebrew/bin/taplo" },
  },
})
