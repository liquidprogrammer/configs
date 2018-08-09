#!/bin/bash

# create link for vimrc
echo -e '\n\nCreating symbolic links for vim...'

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
