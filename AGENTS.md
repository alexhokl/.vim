# AGENTS.md — Neovim Configuration Repository

This document is for agentic coding agents working in this repository. It covers
the repository layout, commands, code style, and conventions to follow when making
changes.

---

## Repository Overview

This is a Neovim configuration managed as a Nix flake and deployed via
Home Manager. It targets Neovim nightly.

```
.vim/
├── init.lua              # Entry point: loads config.* modules then lazy.nvim
├── flake.nix             # Nix flake — environment + Home Manager module
├── Makefile              # Thin wrapper around nix commands
├── lsp/                  # Per-LSP server config files (loaded by nvim-lspconfig)
├── ftplugin/             # Filetype-specific settings (loaded by Neovim automatically)
├── after/ftplugin/       # Filetype overrides applied after built-ins
└── lua/
    ├── plugins.lua       # Core plugin list for lazy.nvim
    ├── config/           # Editor settings (options, keymaps, autocmds, format, filetypes)
    └── plugin/           # Lazy.nvim plugin spec modules (imported via `{ import = "plugin" }`)
```

Plugin specs live in two places:
- `lua/plugins.lua` — core plugins (colorscheme, telescope, treesitter, cmp, lsp, etc.)
- `lua/plugin/*.lua` — additional plugin specs split by domain (git, lsp, ui, dap, …)

Both are imported by `lazy.nvim` via `{ import = "plugins" }` and `{ import = "plugin" }`.

---

## Commands

### Nix / Environment

```bash
# Update the Nix flake lock file
make update

# Validate the flake on all supported platforms (run in CI)
nix flake check --all-systems
```

### Inside Neovim

| Action                         | Command / Key           |
|-------------------------------|-------------------------|
| Open plugin manager UI        | `:Lazy`                 |
| Install / update plugins      | `:Lazy sync`            |
| Update a single plugin        | `:Lazy update <name>`   |
| Install LSP / tools           | `:Mason`                |
| Format current buffer         | `:lua require("conform").format()` |
| Run formatter on save         | Automatic (BufWritePre) |

### No dedicated build/lint/test commands

There is no test suite or lint step to run from the shell. Validation is:
1. **Nix**: `nix flake check --all-systems` (also run in GitHub Actions on push/PR)
2. **Neovim runtime**: open Neovim and verify no startup errors (`:checkhealth`)

To check a single Lua file for syntax errors:

```bash
luajit -b lua/config/options.lua /dev/null
# or via nvim headless:
nvim --headless -c "luafile lua/config/options.lua" -c "qa"
```

---

## Code Style — Lua

All Lua in this repo follows these conventions (enforced by `stylua`).

### Indentation & Spacing

- **2 spaces** per indent level — no tabs.
- Column-guide at 80 characters; keep lines within that where practical.
- One blank line between top-level definitions; avoid double blank lines inside
  a function body.

### Strings

- Use **double quotes** (`"`) for all strings.
- Raw string literals (`[[ ]]`) are acceptable for multi-line strings or patterns
  containing backslashes.

### Tables

- Use **trailing commas** on every element when each element is on its own line:

  ```lua
  local t = {
    "foo",
    "bar",   -- trailing comma here
  }
  ```

- Inline tables (all on one line) do not need trailing commas:
  `{ noremap = true, silent = true }`

### Naming Conventions

| Kind             | Convention    | Example                        |
|-----------------|---------------|--------------------------------|
| Local variables | `snake_case`  | `local cur_buf`                |
| Module-level    | `snake_case`  | `local git_worktree`           |
| Functions       | `snake_case`  | `local function toggle_rn()`   |
| Files           | `snake_case`  | `file_explorer.lua`            |
| Neovim globals  | `vim.*` API   | `vim.opt`, `vim.keymap.set`    |
| Augroup names   | `snake_case`  | `"baby_yosh_autocmds"`         |

Avoid single-letter names except for loop indices (`i`, `k`, `v`) and the
conventional `map` helper used in keymap files.

### Imports / Requires

- Always assign `require()` results to a **local variable**:

  ```lua
  local telescope = require("telescope")
  local builtin   = require("telescope.builtin")
  ```

- Prefer lazy-loading: inside `keys`, `cmd`, or `config` callbacks rather than
  at module top-level, so that plugins only load when needed.
- Lazy-load via the `config` function; call `require()` there, not in the outer
  table spec scope.

### Comments

- `--` for inline or single-line comments.
- `---` (three dashes) for section / block headers:

  ```lua
  --- LSP keymaps -------------------------------------------------------
  ```

- Add `desc` to every `vim.keymap.set` call — it shows in `:Telescope keymaps`
  and `which-key`.

### Error Handling

- Wrap calls that may fail with `pcall`:

  ```lua
  local ok, result = pcall(require, "some.module")
  if not ok then
    vim.notify("Failed to load module: " .. result, vim.log.levels.WARN)
  end
  ```

- Use `vim.notify()` (not `print`) for user-facing messages; pass a log level:
  `vim.log.levels.INFO`, `WARN`, or `ERROR`.

### Keymap Conventions

- All keymaps use `{ noremap = true, silent = true, desc = "..." }`.
- A local `map` helper is the standard pattern in config and LSP files:

  ```lua
  local map = function(mode, keys, command, desc)
    vim.keymap.set(mode, keys, command, { noremap = true, silent = true, desc = desc })
  end
  ```

- LSP on_attach maps also pass `buffer = bufnr`.
- Leader is `,`.

---

## Plugin Spec Conventions (lazy.nvim)

- Set `config = true` when a plugin only needs `require("plugin").setup({})`.
- Use `opts = { ... }` (not `config`) whenever the plugin accepts a plain
  options table — lazy.nvim calls `setup(opts)` automatically.
- Use `config = function(_, opts) ... end` when you need to run extra logic
  after `setup`.
- Lazy-load aggressively: prefer `event`, `keys`, `cmd`, or `ft` triggers over
  `lazy = false`.
- `lazy = false` + high `priority` (≥1000) only for colorschemes or plugins
  that must run before everything else.

---

## LSP Config Files (`lsp/`)

Each file in `lsp/` returns a table consumed by `vim.lsp.enable()` via the
Neovim 0.11+ native LSP config system. The table must contain:

```lua
return {
  settings = { ... },           -- server-specific settings
  on_attach = function(client, bufnr)
    -- define buffer-local keymaps here
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
}
```

Always include `capabilities` so `nvim-cmp` completions work.

---

## Formatting Tools (Conform.nvim)

Formatters are configured in `lua/config/format.lua`. Format-on-save runs at
`BufWritePre` with a 500 ms timeout.

| Filetype     | Formatter(s)                          |
|-------------|---------------------------------------|
| Lua         | `stylua`                              |
| Go          | `goimports`, `gofumpt`                |
| Python      | `ruff_format`, `ruff_fix`             |
| Nix         | `alejandra`                           |
| JS/TS/JSX   | `biome-organize-imports`, `biome`     |
| JSON        | `jq`                                  |
| YAML        | `yamlfmt`                             |
| Rust        | `rustfmt`                             |
| Terraform   | `terraform_fmt`                       |
| TOML        | `taplo`                               |
| (fallback)  | `trim_whitespace`                     |

All formatters must be available in `$PATH`. The Nix flake installs them all.

---

## Dependency Management

- **Neovim plugins** — managed by `lazy.nvim`; lock file is `lazy-lock.json`.
  Commit `lazy-lock.json` changes when intentionally updating plugins.
- **System tools** (LSPs, formatters, CLI tools) — managed by `flake.nix`.
  Run `make update` to update `flake.lock`, then commit both files together.
- **Git submodules** — checked out recursively by CI (`submodules: recursive`).

---

## CI

GitHub Actions (`.github/workflows/nix.yml`) runs `nix flake check --all-systems`
on every push to `main` and on all PRs. Keep the flake evaluating cleanly.
Dependabot keeps GitHub Actions versions updated (`.github/dependabot.yml`).

---

## What to Avoid

- Do not add `lazy = false` without a `priority` value if it could conflict with
  the colorscheme load order.
- Do not use `vim.cmd` where a Lua API equivalent exists (`vim.opt`, `vim.keymap.set`, etc.).
- Do not hardcode absolute paths; use `vim.fn.stdpath("data")` etc.
- Do not leave dead code or commented-out plugin specs without a comment explaining why.
- Do not use `print()` for user-facing output; use `vim.notify()`.
