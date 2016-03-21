#!/bin/bash

# identify the platform
platform="unknown"
platformOs=`uname`
if [[ "$platformOs" == "Linux" ]]; then
	platform='linux'
elif [[ "$platformOs" == "Darwin" ]]; then
	platform='darwin'
fi

# install linux specific apps via apt-get - zsh, tmux, vim, htop
if [[ "$platform" == "linux" ]]; then
	sudo apt-get install zsh tmux vim htop upower
	if ! grep -q "zsh" ~/.bashrc; then
		printf "# Enable zsh once ssh'd into box\nzsh\n" | cat - ~/.bashrc > temp && mv temp ~/.bashrc
	fi
	if ! grep -q "battery" ~/.zshrc; then
		printf "# display battery-status with upower\nalias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E 'state|to\ full|percentage'\n" | cat - ~/.zshrc > temp && mv temp ~/.zshrc
	fi
fi 

# install vundle which manages the vim plugins
git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# setup RussellBradley/vimrc 
# git@github.com:RussellBradley/vimrc.git
rm -rf ./vimrc
git clone git@github.com:RussellBradley/vimrc.git
cd vimrc
cp .vimrc ~/
cd ..
vim +PluginInstall +qall

# Configure git
git config --global user.name "Russell Bradley"
git config --global user.email me@russellbradley.com
git config --global core.editor vim

# install darwin specific tools: tmux, brew, htop
# configure zsh to be default shell
if [[ "$platform" == "darwin" ]]; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update && brew doctor
	brew install tmux htop
	chsh -s /bin/zsh
fi

# Install modified oh-my-zsh that doesn't launch automatically
# https://github.com/russellbradley/oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/russellbradley/oh-my-zsh/master/tools/install.sh)"

# add requirements for vim colorthemes to zshrc
# requires setup.sh to be ran twice to update ~/.zshrc since not yet created.
if ! grep -q "xterm-256color" ~/.zshrc; then
	printf "# Required for vim colorthemes\nexport TERM='xterm-256color'\n" | cat - ~/.zshrc > temp && mv temp ~/.zshrc
fi
zsh
