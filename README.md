dotfiles-vim
============

My simple vim configuration.

How to use
==========

First, install [pathogen][].

Then:

	$ cd ~/.vim/bundle
	$ git clone https://github.com/dsimidzija/dotfiles-vim.git .
	$ git submodule init
	$ git submodule update

Edit your ~/.vimrc and add the following:

	source ~/.vim/bundle/main.vim

You may or may not need one or more of the following:

 * exuberant-ctags
 * patched fonts for vim-airline
 * `CoffeeTags` ruby gem (`rvmsudo gem install CoffeeTags`) if using CoffeeScript

After checking out all the submodules, go to ~/.vim/bundle/phpctags
and run `make`.

[pathogen]: https://github.com/tpope/vim-pathogen
