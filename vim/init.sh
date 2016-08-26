#!/bin/bash

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# create links for config files
ln -s $PWD/vimrc ~/.vimrc

# install vim-plug packages
vim +PlugInstall +qall
