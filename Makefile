SHELL := bash

.PHONY: update
update: ## Updates the nix flake.
	nix flake update

.PHONY: checkhealth
checkhealth: ## Runs :checkhealth in headless Neovim and prints the report.
	nvim --headless -c "checkhealth" -c "w /tmp/nvim-health.txt" -c "qa" 2>/dev/null; cat /tmp/nvim-health.txt

.PHONY: test
test: ## Run unit tests with headless Neovim.
	nvim --headless -u NONE -l tests/test_ts_utils.lua

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
