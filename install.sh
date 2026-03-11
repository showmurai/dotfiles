#!/bin/sh

path=$(pwd)
echo "Installing dotfiles from: $path"

# dpp.vim bootstrap (Deno required)
if [ ! -d ~/.vim/bundles/dpp.vim ]; then
  mkdir -p ~/.vim/bundles
  git clone https://github.com/Shougo/dpp.vim.git ~/.vim/bundles/dpp.vim
  git clone https://github.com/vim-denops/denops.vim.git ~/.vim/bundles/denops.vim
  git clone https://github.com/Shougo/dpp-ext-installer.git ~/.vim/bundles/dpp-ext-installer
  git clone https://github.com/Shougo/dpp-ext-lazy.git ~/.vim/bundles/dpp-ext-lazy
  git clone https://github.com/Shougo/dpp-ext-toml.git ~/.vim/bundles/dpp-ext-toml
  git clone https://github.com/Shougo/dpp-protocol-git.git ~/.vim/bundles/dpp-protocol-git
fi

# dpp.vim config files
mkdir -p ~/.vim/dpp
if [ ! -f ~/.vim/dpp/dpp.ts ]; then
  cp "$path"/.vim/dpp/dpp.ts ~/.vim/dpp/dpp.ts
fi
if [ ! -f ~/.vim/dpp/plugins.toml ]; then
  cp "$path"/.vim/dpp/plugins.toml ~/.vim/dpp/plugins.toml
fi
if [ ! -f ~/.vim/dpp/plugins_lazy.toml ]; then
  cp "$path"/.vim/dpp/plugins_lazy.toml ~/.vim/dpp/plugins_lazy.toml
fi

# symlink dotfiles
ln -fs "$path"/.zprofile "$HOME"/.zprofile
ln -fs "$path"/.zshrc "$HOME"/.zshrc
ln -fs "$path"/.vimrc "$HOME"/.vimrc
ln -fs "$path"/.gitconfig "$HOME"/.gitconfig
ln -fs "$path"/.editorconfig "$HOME"/.editorconfig
ln -fs "$path"/.tigrc "$HOME"/.tigrc
mkdir -p "$HOME"/.config/ghostty
ln -fs "$path"/.config/ghostty/config "$HOME"/.config/ghostty/config

echo "Done!"
