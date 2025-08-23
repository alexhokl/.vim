# Neovim Configuration (`~/.vim`) Agent Guidelines

This document provides a summary of the conventions and practices in this Neovim configuration repository.

## Commands

- **Update Plugins**: Run `:Lazy` inside Neovim to update plugins.
- **Update Nix Flake**: Run `make update` to update the Nix environment.

There are no dedicated build, lint, or test commands. Linting and formatting are handled by LSP and `conform.nvim` within the editor.

## Code Style (Lua)

- **Formatting**:
  - **Indentation**: Use 2 spaces for indentation.
  - **Strings**: Use double quotes (`"`) for strings.
  - **Commas**: Use trailing commas in tables.

- **Naming Conventions**:
  - **Variables**: `snake_case` (e.g., `local_variable`).
  - **Files**: `snake_case` (e.g., `file_name.lua`).

- **Error Handling**:
  - Use `pcall()` to wrap calls that might fail, ensuring graceful error handling.

- **Modules and Imports**:
  - Use `require()` to import modules.
  - Assign required modules to local variables (e.g., `local my_module = require("my_module")`).

- **Comments**:
  - Use `--` for single-line comments.
  - Use `---` for section headers.

- **Dependency Management**:
  - Neovim plugins are managed with `lazy.nvim` in `lua/plugins.lua`.
  - The development environment is managed with Nix (`flake.nix`).
