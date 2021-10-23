SHELL := bash

XDG_CONFIG_HOME ?= $(HOME)/.config

.PHONY: install
install: ## Sets up symlink for user and root .vimrc for vim and neovim.
	ln -snf "$(HOME)/.vim/vimrc" "$(HOME)/.vimrc"
	mkdir -p "$(XDG_CONFIG_HOME)"
	ln -snf "$(HOME)/.vim" "$(XDG_CONFIG_HOME)/nvim"
	ln -snf "$(HOME)/.vimrc" "$(XDG_CONFIG_HOME)/nvim/init.vim"
	@if [[ -d /root ]]; then \
		sudo ln -snf "$(HOME)/.vim" /root/.vim; \
		sudo ln -snf "$(HOME)/.vimrc" /root/.vimrc; \
		sudo mkdir -p /root/.config; \
		sudo ln -snf "$(HOME)/.vim" /root/.config/nvim; \
		sudo ln -snf "$(HOME)/.vimrc" /root/.config/nvim/init.vim; \
	fi
	nvim \
		-c "UpdateRemotePlugins" \
		-c "Copilot setup" \
		vimrc

.PHONY: update
update: update-pathogen update-plugins avante-build ## Updates pathogen and all plugins.

.PHONY: update-plugins
update-plugins: ## Updates all plugins.
	git submodule update --init --recursive
	git submodule update --remote
	git submodule foreach 'git pull --recurse-submodules origin `git rev-parse --abbrev-ref HEAD`'

.PHONY: avante-build
avante-build: ## Builds avante.vim from source.
	$(MAKE) -C bundle/avante.nvim

.PHONY: update-pathogen
update-pathogen: ## Updates pathogen.
	curl -LSso $(CURDIR)/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

.PHONY: README.md
README.md: ## Generates and updates plugin info in README.md.
	@sed -i '/## Plugins Used/q' $@
	@git  submodule --quiet foreach bash -c "echo -e \"* [\$$(git config --get remote.origin.url | sed 's#https://##' | sed 's#ssh://##' | sed 's#git://##' | sed 's/.git//')](\$$(git config --get remote.origin.url | sed 's#ssh://#https://#'))\"" >> $@

check_defined = \
				$(strip $(foreach 1,$1, \
				$(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
				  $(if $(value $1),, \
				  $(error Undefined $1$(if $2, ($2))$(if $(value @), \
				  required by target `$@')))

.PHONY: remove-submodule
remove-submodule: ## Removes a git submodule (ex MODULE=bundle/nginx.vim).
	@:$(call check_defined, MODULE, path of module to remove)
	mv $(MODULE) $(MODULE).tmp || true
	git submodule deinit -f -- $(MODULE) || true
	$(RM) -r .git/modules/$(MODULE) || true
	git rm -f $(MODULE) || true
	$(RM) -r $(MODULE).tmp || true
	$(MAKE) README.md

.PHONY: update-alexhokl
update-alexhokl:
	cd bundle/vim-snippets && git pull origin master
	cd bundle/tcomment_vim && git pull origin master
	cd bundle/vim-unimpaired && git pull origin master
	cd bundle/editorconfig-vim && git pull origin master
	cd bundle/vim-sandwich && git pull origin master
	cd bundle/mason.nvim && git pull origin main
	cd bundle/mason-lspconfig.nvim && git pull origin main
	cd bundle/cmp-treesitter && git pull origin master
	cd bundle/lspkind-nvim && git pull origin master
	cd bundle/lsp_signature.nvim && git pull origin master
	cd bundle/nvim-treesitter-textobjects && git pull origin master
	cd bundle/nlua.nvim && git pull origin master
	cd bundle/vim-sayonara && git pull origin master
	cd bundle/sqls.nvim && git pull origin main
	cd bundle/nvim-ts-autotag && git pull origin main
	cd bundle/twilight.nvim && git pull origin main
	cd bundle/tabular && git pull origin master
	cd bundle/nvim-treehopper && git pull origin master
	cd bundle/gitlinker.nvim && git pull origin master
	cd bundle/todo-comments.nvim && git pull origin main
	cd bundle/targets.vim && git pull origin master
	cd bundle/cmp-nvim-ultisnips && git pull origin main
	cd bundle/ultisnips && git pull origin master
	cd bundle/trouble.nvim && git pull origin main
	cd bundle/telescope-ui-select.nvim && git pull origin master
	cd bundle/fidget.nvim && git pull origin main
	cd bundle/nvim-treesitter-context && git pull origin master
	cd bundle/bullets.vim && git pull origin master
	cd bundle/d2-vim && git pull origin master
	cd bundle/git-conflict.nvim && git pull origin main
	cd bundle/flutter-tools.nvim && git pull origin main
	cd bundle/nvim-dap && git pull origin master
	cd bundle/nvim-dap-ui && git pull origin master
	cd bundle/nvim-dap-go && git pull origin main
	cd bundle/nvim-dap-virtual-text && git pull origin master
	cd bundle/nvim-dap-python && git pull origin master
	cd bundle/syntax-tree-surfer && git pull origin master
	cd bundle/yaml-companion.nvim && git pull origin main
	cd bundle/git-worktree.nvim	&& git pull origin master
	cd bundle/csharpls-extended-lsp.nvim && git pull origin master
	cd bundle/nvim-dap-dotnet && git pull origin main
	cd bundle/vim-dadbod-completion && git pull origin master
	cd bundle/vim-dadbod-ui && git pull origin master
	cd bundle/vim-dadbod && git pull origin master
	cd bundle/nvim-notify && git pull origin master
	cd bundle/nvim-md-open-link && git pull origin main
	cd bundle/nvim-nio && git pull origin master
	cd bundle/copilot.vim && git pull origin release
	cd bundle/oil.nvim && git pull origin master

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
