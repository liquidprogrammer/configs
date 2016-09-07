#!/bin/bash

# install vim-gtk - to be able to work with system clipboard
sudo apt-get install vim-gtk

# install ctags
sudo apt-get install exuberant-ctags

# install YCM dependencies
sudo apt-get install build-essential cmake
sudo apt-get install python-dev python3-dev

# install vim-plug
echo -e '\n\nInstalling Plug.vim...'
plug_vim_path=~/.vim/autoload/plug.vim
if [ ! -e $plug_vim_path ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo 'Done.'
else
  echo 'Already installed.'
fi



# create link for vimrc
echo -e '\n\nCreating links...'

declare -A paths
paths=( 
  ["$PWD/.vimrc"]="$HOME/.vimrc"
  ["$PWD/ftplugin"]="$HOME/.vim/ftplugin"
)
for path_by_pwd in "${!paths[@]}"; do
  path_by_root="${paths[$path_by_pwd]}"
  if [ ! -L $path_by_root ]; then
    ln -s $path_by_pwd $path_by_root
  fi
  echo "Link '$path_by_root' to '$path_by_pwd' created." 
done
echo -e 'Done.\n\n'



# install vim-plug packages
vim +PlugInstall +qall
