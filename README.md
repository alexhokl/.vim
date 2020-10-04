.vim
====

My vim dot files. the `.vimrc` file is saved to [vimrc](https://github.com/alexhokl/.vim/blob/master/vimrc).

**Table of Contents**

<!-- toc -->

- [About](#about)
  * [Installing](#installing)
  * [Pathogen](#pathogen)
- [Contributing](#contributing)
  * [Using the `Makefile`](#using-the-makefile)
- [Plugins Used](#plugins-used)

<!-- tocstop -->

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
cd $HOME
git clone --recursive https://github.com/alexhokl/.vim.git .vim
cd $HOME/.vim
git submodule update --init
make install
```

Open nvim and execute the following commands

```
:UpdateRemotePlugins
:GoInstallBinaries
```

### To update the plugins (submodules)

```sh
make update-alexhokl
```

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

## Plugins Used
* [github.com/w0rp/ale](https://github.com/w0rp/ale)
* [github.com/dart-lang/dart-vim-plugin](https://github.com/dart-lang/dart-vim-plugin)
* [github.com/editorconfig/editorconfig-vim](https://github.com/editorconfig/editorconfig-vim)
* [github.com/junegunn/fzf](https://github.com/junegunn/fzf)
* [github.com/junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)
* [github.com/junegunn/limelight.vim](https://github.com/junegunn/limelight.vim)
* [github.com/vivien/vim-linux-coding-style](https://github.com/vivien/vim-linux-coding-style.git)
* [github.com/chr4/nginx.vim](https://github.com/chr4/nginx.vim.git)
* [github.com/OmniSharp/omnisharp-vim](https://github.com/OmniSharp/omnisharp-vim)
* [github.com/jessfraz/openai.vim](https://github.com/jessfraz/openai.vim.git)
* [github.com/rust-lang/rust.vim](https://github.com/rust-lang/rust.vim.git)
* [github.com/godlygeek/tabular](https://github.com/godlygeek/tabular.git)
* [github.com/tomtom/tcomment_vim](https://github.com/tomtom/tcomment_vim)
* [github.com/tomtom/tlib_vim](https://github.com/tomtom/tlib_vim)
* [github.com/SirVer/ultisnips](https://github.com/SirVer/ultisnips)
* [github.com/MarcWeber/vim-addon-mw-utils](https://github.com/MarcWeber/vim-addon-mw-utils)
* [github.com/vim-airline/vim-airline](https://github.com/vim-airline/vim-airline.git)
* [github.com/vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes.git)
* [ssh:/hub.com/alexhokl/vim-alexhokl](ssh://github.com/alexhokl/vim-alexhokl)
* [github.com/moll/vim-bbye](https://github.com/moll/vim-bbye.git)
* [github.com/ntpeters/vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace.git)
* [github.com/ap/vim-buftabline](https://github.com/ap/vim-buftabline.git)
* [github.com/crosbymichael/vim-cfmt](https://github.com/crosbymichael/vim-cfmt)
* [github.com/altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized.git)
* [github.com/tpope/vim-endwise](https://github.com/tpope/vim-endwise.git)
* [github.com/tpope/vim-five.git](https://github.com/tpope/vim-fugitive.git)
* [github.com/tpope/vim.git](https://github.com/tpope/vim-git.git)
* [github.com/airblade/vimgutter.git](https://github.com/airblade/vim-gitgutter.git)
* [github.com/fatih/vim-go](https://github.com/fatih/vim-go.git)
* [github.com/fatih/vim-hclfmt](https://github.com/fatih/vim-hclfmt.git)
* [github.com/Yggdroot/indentLine](https://github.com/Yggdroot/indentLine.git)
* [github.com/elzr/vim-json](https://github.com/elzr/vim-json.git)
* [github.com/mxw/vim-jsx](https://github.com/mxw/vim-jsx)
* [github.com/natebosch/vim-lsc](https://github.com/natebosch/vim-lsc)
* [github.com/natebosch/vim-lsc-dart](https://github.com/natebosch/vim-lsc-dart)
* [github.com/plasticboy/vim-markdown](https://github.com/plasticboy/vim-markdown.git)
* [github.com/harenome/vim-mipssyntax](https://github.com/harenome/vim-mipssyntax.git)
* [github.com/terryma/vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors.git)
* [github.com/uarun/vim-protobuf](https://github.com/uarun/vim-protobuf.git)
* [github.com/hynek/vim-python-pep8-indent](https://github.com/hynek/vim-python-pep8-indent.git)
* [github.com/tpope/vim-rhubarb](https://github.com/tpope/vim-rhubarb)
* [github.com/machakann/vim-sandwich](https://github.com/machakann/vim-sandwich)
* [github.com/mhinz/vim-sayonara](https://github.com/mhinz/vim-sayonara.git)
* [github.com/tpope/vim-sensible](https://github.com/tpope/vim-sensible.git)
* [github.com/garbas/vim-snipmate](https://github.com/garbas/vim-snipmate)
* [github.com/honza/vim-snippets](https://github.com/honza/vim-snippets)
* [github.com/tpope/vim-surround](https://github.com/tpope/vim-surround.git)
* [github.com/machakann/vim-swap](https://github.com/machakann/vim-swap)
* [github.com/wgwoods/vim-systemd-syntax](https://github.com/wgwoods/vim-systemd-syntax.git)
* [github.com/hashivim/vim-terraform](https://github.com/hashivim/vim-terraform.git)
* [github.com/cespare/vim-toml](https://github.com/cespare/vim-toml.git)
* [github.com/tpope/vim-unimpaired](https://github.com/tpope/vim-unimpaired)
* [github.com/stephpy/vim-yaml](https://github.com/stephpy/vim-yaml.git)
