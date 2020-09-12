dotfiles-vim
============

My simple vim configuration.

How to use
==========

First, install [vim-plug][].

Then:

	$ mkdir -p ~/.vim/repo
	$ cd ~/.vim/repo
	$ git clone https://github.com/dsimidzija/dotfiles-vim.git .
	$ ln -s ~/.vim/repo/coc-settings.json ~/.vim/coc-settings.json

Edit your ~/.vimrc and add the following:

	source ~/.vim/repo/main.vim

You may or may not need one or more of the following:

 * patched fonts for vim-airline
 * `CoffeeTags` ruby gem (`rvmsudo gem install CoffeeTags`) if using CoffeeScript

Setup inside vim
================

	PlugInstall
	CocInstall coc-json coc-python coc-snippets coc-vimlsp coc-yaml

Maintenance
===========

	PlugUpdate
	CocUpdate

[vim-plug]: https://github.com/junegunn/vim-plug
