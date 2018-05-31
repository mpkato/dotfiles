#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0);pwd)
ln -sf $SCRIPT_DIR/.vimrc $HOME/.vimrc
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim +NeoBundleInstall +qall
