#!/bin/sh

path=`pwd`
echo "$path"

# if [ ! -e ~/zaw ]; then
#   git clone git://github.com/zsh-users/zaw.git ~/zaw/
# fi

if [ ! -e ~/.vim/bundle ]; then
  mkdir -p ~/.vim/bundle
  git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

ln -fs "$path"/.zprofile $HOME/.zprofile
ln -fs "$path"/.zshrc $HOME/.zshrc
ln -fs "$path"/.vimrc $HOME/.vimrc
ln -fs "$path"/.gitconfig $HOME/.gitconfig
ln -fs "$path"/.editorconfig $HOME/.editorconfig
ln -fs "$path"/.tigrc $HOME/.tigrc
