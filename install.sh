#!/bin/sh

path=`pwd`
echo "$path"

ln -fs "$path"/.zprofile $HOME/.zprofile
ln -fs "$path"/.zshrc $HOME/.zshrc
ln -fs "$path"/.vimrc $HOME/.vimrc
ln -fs "$path"/.gitconfig $HOME/.gitconfig
ln -fs "$path"/.editorconfig $HOME/.editorconfig
