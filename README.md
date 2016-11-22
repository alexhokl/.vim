.vim
====

My vim dot files. the `.vimrc` file is saved to [vimrc](https://github.com/alexhokl/.vim/blob/master/vimrc).

This repository depends on [neovim](https://neovim.io/).

## About

### Installing

Just run the following commands via terminal to get perfectly set up:

Note: Make sure that python 3.6.1 or above is installed.

```sh
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim
pip install setuptools
pip install --upgrade pynvim
pip3 install --upgrade pynvim
sudo npm install -g tree-sitter-cli
cd $HOME
git clone --recursive https://github.com/alexhokl/.vim.git .vim
cd $HOME/.vim
git submodule update --init
make install
```

### To update the plugins (submodules)

```sh
make update-alexhokl
```

### To enable more diagnostics with .NET

Configure `$HOME/.omnisharp/omnisharp.json` with the following.

```json
{
  "RoslynExtensionsOptions": {
    "EnableAnalyzersSupport": true,
    "LocationPaths": [
    ]
  },
  "FormattingOptions": {
    "EnableEditorConfigSupport": true
  }
}
```

### Language servers

Most of the language servers can be installed via
[mason.nvim](https://github.com/williamboman/mason.nvim) except the following.

- [kittycad/kcl-lsp](https://github.com/kittycad/kcl-lsp)
- [lighttiger2505/sqls](https://github.com/lighttiger2505/sqls)

### Debugging

Adapters of DAP can be installed via `mason.nvim`.

- `codelldb`
- `dart-debug-adapter`
- `debugpy`
- `delve`

The current exception is the combination of `netcoredbg` and Apple Silicon. In
this case `netcoredbg` needs to be on the machine. Detailed steps can be found
on https://github.com/Samsung/netcoredbg. Roughly the steps involve the
following.

```sh
mkdir build
cd build
CC=clang CXX=clang++ cmake ..
make
sudo make install
```

Currently, debug adapter of flutter does not handle multiple connected devices
yet. To get around the problem, `flutter config --no-enable-web` is used.

### Pathogen
The vim dot files make use of the excellent [Pathogen](https://github.com/tpope/vim-pathogen) runtime path manager to install plugins and runtime files into their own private directiories.

Currently using version 2.4 of Pathogen

## Contributing

### Using the `Makefile`

You can use the [`Makefile`](Makefile) to run a series of commands.

```console
$ make help
install                        Sets up symlink for user and root .vimrc for vim and neovim.
README.md                      Generates and updates plugin info in README.md.
remove-submodule               Removes a git submodule (ex MODULE=bundle/nginx.vim).
update-pathogen                Updates pathogen.
update-plugins                 Updates all plugins.
update-alexhokl                Updates plugins added by me.
update                         Updates pathogen and all plugins.
```

##### To add a new plugin

```sh
git submodule add https://github.com/OmniSharp/omnisharp-vim ~/.vim/bundle/omnisharp-vim
```

## Shortcuts

- `Ctrl-P`: Find files
- `Ctrl-G`: Live grep
- `Ctrl-B`: Search git branches
- `Ctrl-A`: Toggle the file sidebar
- `Ctrl-R`: Refresh the file sidebar
- `Ctrl-N`: Multiple cursor support
- `Ctrl-X`: Switch to the next buffer
- `Ctrl-Z`: Switch to the previous buffer
- `Ctrl-T`: Open a floating terminal
- `<Space>`: Center the screen to the cursor

There's a lot more if you hit `,?` you can peruse all the ones connected to the leader `,`

## Plugins Used
* [github.com/yetone/avante.nvim](https://github.com/yetone/avante.nvim.git)
* [github.com/akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git)
* [github.com/dkarter/bullets.vim](https://github.com/dkarter/bullets.vim)
* [github.com/hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer.git)
* [github.com/petertriho/cmp.git](https://github.com/petertriho/cmp-git.git)
* [github.com/hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp.git)
* [github.com/quangnguyen30192/cmp-nvim-ultisnips](https://github.com/quangnguyen30192/cmp-nvim-ultisnips)
* [github.com/hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path.git)
* [github.com/f3fora/cmp-spell](https://github.com/f3fora/cmp-spell.git)
* [github.com/ray-x/cmp-treesitter](https://github.com/ray-x/cmp-treesitter)
* [github.com/hrsh7th/cmp-vsnip](https://github.com/hrsh7th/cmp-vsnip.git)
* [github.com/yuys13/collama.nvim](https://github.com/yuys13/collama.nvim)
* [github.comhub/copilot.vim.git](https://github.com/github/copilot.vim.git)
* [github.com/Decodetalkers/csharpls-extended-lsp.nvim](https://github.com/Decodetalkers/csharpls-extended-lsp.nvim)
* [github.com/terrastruct/d2-vim](https://github.com/terrastruct/d2-vim)
* [github.com/glepnir/dashboard-nvim](https://github.com/glepnir/dashboard-nvim.git)
* [github.com/sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim)
* [github.com/stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim.git)
* [github.com/editorconfig/editorconfig-vim](https://github.com/editorconfig/editorconfig-vim)
* [github.com/j-hui/fidget.nvim](https://github.com/j-hui/fidget.nvim)
* [github.com/akinsho/flutter-tools.nvim](https://github.com/akinsho/flutter-tools.nvim)
* [github.com/David-Kunz/gen.nvim](https://github.com/David-Kunz/gen.nvim)
* [github.com/akinsho-conflict.nvim](https://github.com/akinsho/git-conflict.nvim)
* [github.com/ThePrimeagen-worktree.nvim](https://github.com/ThePrimeagen/git-worktree.nvim)
* [github.com/ruifmlinker.nvim](https://github.com/ruifm/gitlinker.nvim)
* [github.com/lewis6991signs.nvim.git](https://github.com/lewis6991/gitsigns.nvim.git)
* [github.com/axkirillov/hbac.nvim](https://github.com/axkirillov/hbac.nvim)
* [github.com/lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim.git)
* [gitlab.com/HiPhish/jinja.vim](https://gitlab.com/HiPhish/jinja.vim)
* [github.com/ray-x/lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim)
* [github.com/onsails/lspkind-nvim](https://github.com/onsails/lspkind-nvim)
* [github.com/nvimdev/lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim.git)
* [github.com/nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim.git)
* [github.com/williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
* [github.com/williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
* [github.com/chr4/nginx.vim](https://github.com/chr4/nginx.vim.git)
* [github.com/tjdevries/nlua.nvim](https://github.com/tjdevries/nlua.nvim)
* [github.com/MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim.git)
* [github.com/hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp.git)
* [github.com/mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)
* [github.com/alexhokl/nvim-dap-dotnet](https://github.com/alexhokl/nvim-dap-dotnet)
* [github.com/leoluz/nvim-dap-go](https://github.com/leoluz/nvim-dap-go)
* [github.com/mfussenegger/nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)
* [github.com/rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
* [github.com/theHamsta/nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)
* [github.com/neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig.git)
* [github.com/alexhokl/nvim-md-open-link](https://github.com/alexhokl/nvim-md-open-link)
* [github.com/nvim-neotest/nvim-nio](https://github.com/nvim-neotest/nvim-nio)
* [github.com/rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify)
* [github.com/kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua.git)
* [github.com/mfussenegger/nvim-treehopper](https://github.com/mfussenegger/nvim-treehopper)
* [github.com/nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter.git)
* [github.com/nvim-treesitter/nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
* [github.com/nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
* [github.com/windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
* [github.com/nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons.git)
* [github.com/pwntester/octo.nvim](https://github.com/pwntester/octo.nvim.git)
* [github.com/stevearc/oil.nvim](https://github.com/stevearc/oil.nvim.git)
* [github.com/nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim.git)
* [github.com/nanotee/sqls.nvim](https://github.com/nanotee/sqls.nvim)
* [github.com/ziontee113/syntax-tree-surfer](https://github.com/ziontee113/syntax-tree-surfer)
* [github.com/godlygeek/tabular](https://github.com/godlygeek/tabular)
* [github.com/wellle/targets.vim](https://github.com/wellle/targets.vim)
* [github.com/tomtom/tcomment_vim](https://github.com/tomtom/tcomment_vim)
* [github.com/nvim-telescope/telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim)
* [github.com/nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git)
* [github.com/folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
* [github.com/folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim.git)
* [github.com/folke/trouble.nvim](https://github.com/folke/trouble.nvim)
* [github.com/folke/twilight.nvim](https://github.com/folke/twilight.nvim)
* [github.com/SirVer/ultisnips](https://github.com/SirVer/ultisnips)
* [github.com/ntpeters/vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace.git)
* [github.com/alexhokl/vim-dadbod](https://github.com/alexhokl/vim-dadbod)
* [github.com/kristijanhusak/vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion)
* [github.com/kristijanhusak/vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)
* [github.com/tpope/vim-endwise](https://github.com/tpope/vim-endwise.git)
* [github.com/tpope/vim-five.git](https://github.com/tpope/vim-fugitive.git)
* [github.com/fatih/vim-hclfmt](https://github.com/fatih/vim-hclfmt.git)
* [github.com/plasticboy/vim-markdown](https://github.com/plasticboy/vim-markdown.git)
* [github.com/harenome/vim-mipssyntax](https://github.com/harenome/vim-mipssyntax.git)
* [github.com/LnL7/vim-nix](https://github.com/LnL7/vim-nix.git)
* [github.com/uarun/vim-protobuf](https://github.com/uarun/vim-protobuf.git)
* [github.com/tpope/vim-rhubarb](https://github.com/tpope/vim-rhubarb.git)
* [github.com/machakann/vim-sandwich](https://github.com/machakann/vim-sandwich)
* [github.com/mhinz/vim-sayonara](https://github.com/mhinz/vim-sayonara)
* [github.com/tpope/vim-sensible](https://github.com/tpope/vim-sensible.git)
* [github.com/honza/vim-snippets](https://github.com/honza/vim-snippets)
* [github.com/tpope/vim-surround](https://github.com/tpope/vim-surround.git)
* [github.com/wgwoods/vim-systemd-syntax](https://github.com/wgwoods/vim-systemd-syntax.git)
* [github.com/cespare/vim-toml](https://github.com/cespare/vim-toml.git)
* [github.com/tpope/vim-unimpaired](https://github.com/tpope/vim-unimpaired)
* [github.com/mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi.git)
* [github.com/hrsh7th/vim-vsnip](https://github.com/hrsh7th/vim-vsnip.git)
* [github.com/someone-stole-my-name/yaml-companion.nvim](https://github.com/someone-stole-my-name/yaml-companion.nvim)
