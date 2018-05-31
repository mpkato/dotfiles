#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0);pwd)
ln -sf $SCRIPT_DIR/.vimrc $HOME/.vimrc
ln -sf $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf
TMUX_ALIAS="alias tmux=\"tmux -2\""
PROFILE=$HOME/.bash_profile
grep -qF "$TMUX_ALIAS" $PROFILE || echo $TMUX_ALIAS >> $PROFILE
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim +NeoBundleInstall +qall
