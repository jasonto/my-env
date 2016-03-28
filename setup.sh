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
	sudo apt-get install zsh tmux vim htop upower python-setuptools libxml2-dev libxslt1-dev python-dev cmake nodejs
	if ! grep -q "zsh" ~/.bashrc; then
		printf "# Enable zsh once ssh'd into box\nzsh\n" | cat - ~/.bashrc > temp && mv temp ~/.bashrc
	fi
	if ! grep -q "battery" ~/.zshrc; then
		printf "# display battery-status with upower\nalias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E 'state|to\ full|percentage''\n" | cat - ~/.zshrc > temp && mv temp ~/.zshrc
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
	brew install tmux htop mercurial vim python cmake
	curl "https://nodejs.org/dist/latest/node-${VERSION:-$(wget -qO- https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')}.pkg" > "$HOME/Downloads/node-latest.pkg" && sudo installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"
	# compile  YouCompleteMe
	mkdir ~/ycm_build
	cd ~/ycm_build
	cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
	cmake --build . --target ycm_core --config Release
	cd ~/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/tern_runtime && npm install --production
	cd ~
	# change shell zsh
	chsh -s /bin/zsh
fi

# Install modified oh-my-zsh that doesn't launch automatically
# https://github.com/russellbradley/oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/russellbradley/oh-my-zsh/master/tools/install.sh)"

# add requirements for vim colorthemes to zshrc
# requires setup.sh to be ran twice to update ~/.zshrc since not yet created.
if ! grep -q "YCM_core" ~/.zshrc; then
	printf "# resolve python crashing after making YCM_core'\n
	# https://github.com/Valloric/YouCompleteMe/issues/620\n
	export DYLD_FORCE_FLAT_NAMESPACE=1\n" | cat - ~/.zshrc > temp && mv temp ~/.zshrc
	cd ~
fi

# required for vim colorthemes to work correctly
if ! grep -q "xterm-256color" ~/.zshrc; then
	printf "# Required for vim colorthemes\nexport TERM='xterm-256color'\n" | cat - ~/.zshrc > temp && mv temp ~/.zshrc
fi
# kickoff oh-my-zsh
zsh
