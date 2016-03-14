#!/bin/bash

# install vundle which manages the vim plugins
git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# setup RussellBradley/vimrc 
# git@github.com:RussellBradley/vimrc.git
rm -rf ./vimrc
git clone git@github.com:RussellBradley/vimrc.git
cd vimrc
mv .vimrc ~/
vim +PluginInstall +qall

# Configure git
git config --global user.name "Russell Bradley"
git config --global user.email me@russellbradley.com
git config --global core.editor vim

