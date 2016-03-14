#!/bin/bash

platform="unknown"
platformOs=`uname`
if [[ "$platformOs" == "Linux" ]]; then
	platform='linux'
elif [[ "$platformOs" == "Darwin" ]]; then
	platform='darwin'
fi

# install linux specific apps via apt-get - zsh, tmux, vim, htop
if [[ "$platform" == "linux" ]]; then 
	sudo apt-get update && sudo apt-get install zsh tmux vim htop
fi 

# install vundle which manages the vim plugins
git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# setup RussellBradley/vimrc 
# git@github.com:RussellBradley/vimrc.git
rm -rf ./vimrc
git clone git@bitbucket.org:RussellBradley/vimrc.git
cd vimrc
cp .vimrc ~/
cd ..
vim +PluginInstall +qall

# Configure git
git config --global user.name "Russell Bradley"
git config --global user.email me@russellbradley.com
git config --global core.editor vim


# Install oh-my-zsh
# https://github.com/robbyrussell/oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
zsh

