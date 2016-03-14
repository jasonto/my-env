#!/bin/bash

# install vundle which manages the vim plugins
git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install oh-my-zsh
# https://github.com/robbyrussell/oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# setup RussellBradley/vimrc 
# git@github.com:RussellBradley/vimrc.git
rm -rf ./vimrc
git clone git@bitbucket.org:RussellBradley/vimrc.git
cd vimrc
mv .vimrc ~/
echo "You may receive or have received an error regarding line 118: Cannot find color scheme mushroom if this is your initial setup. This is expected. If no error occurred, ignore this message."
vim +PluginInstall +qall

# Configure git
git config --global user.name "Russell Bradley"
git config --global user.email me@russellbradley.com
git config --global core.editor vim


