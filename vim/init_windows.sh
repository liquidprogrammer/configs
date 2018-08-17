#!/bin/bash

# We still need this.
windows() { [[ -n "$WINDIR" ]]; }

# Cross-platform symlink function. With one parameter, it will check
# whether the parameter is a symlink. With two parameters, it will create
# a symlink to a file or directory, with syntax: link $linkname $target
link() {
    target=$(echo "$2" | sed -e 's/^\///' -e 's/\//\\/g' -e 's/^./\0:/')
    linkname=$(echo "$1" | sed -e 's/^\///' -e 's/\//\\/g' -e 's/^./\0:/')
    if [[ -z "$target" ]]; then
        # Link-checking mode.
        if windows; then
            fsutil reparsepoint query "$linkname" > /dev/null
        else
            [[ -h "$linkname" ]]
        fi
    else
        # Link-creation mode.
        if windows; then
            # Windows needs to be told if it's a directory or not. Infer that.
            # Also: note that we convert `/` to `\`. In this case it's necessary.
            if [[ -d "$2" ]]; then
                cmd <<< "mklink /D \"$linkname\" \"$target\"" > /dev/null
            else
                cmd <<< "mklink \"$linkname\" \"$target\"" > /dev/null
            fi
        else
            # You know what? I think ln's parameters are backwards.
            ln -s "$2" "$1"
        fi
    fi
}

# create link for vimrc
echo -e '\n\nCreating symbolic links for vim...'

if [ ! -d "$HOME/.vim" ]; then
	mkdir "$HOME/.vim"
fi

link "$HOME/_vimrc" "$PWD/.vimrc"
#link "$HOME/.vim/ftplugin"  "$PWD/ftplugin"
link "$HOME/.vim/colors" "$PWD/colors"

echo -e 'Done.\n\n'
