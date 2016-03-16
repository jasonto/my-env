my-env
======

Whether you were shouldering me while I was debugging an issue, or caught a glimpse of my computer screen with your peripheral vision, you probably noticed my pimped out vim color scheme and multiple tmux sessions. Setting up your environment should never be a painful process, and if you like how you see things set up in my environment here's an easy way to have it in yours. 


Prerequisites / Supported Platforms
-----

**Disclaimer**: my-env only works on unix-based operating systems (Mac OS X or Linux)
- curl or wget should be installed
- git should be installed


Setup / Basic Installation 
-----

Execute the the setup file to setup my-env

    ./setup # installs my-env
    
Configuration
-----

By default my-env set's your global git config settings to the authors (mine). Update these lines in the setup.sh file to reflect your own. 

    git config --global user.name "Russell Bradley"
    git config --global user.email me@russellbradley.com


Tools
-----

These are the tools that make up my-env and will be installed after the setup completes.

**tmux** 

What is a terminal multiplexer? It lets you switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal. 

**htop**

htop is an interactive system-monitor process-viewer. It is designed as an alternative to the Unix program top. It shows a frequently updated list of the processes running on a computer, normally ordered by the amount of CPU usage.

**oh-my-zsh**

A delightful community-driven framework for managing your zsh configuration. Includes 200+ optional plugins (rails, git, OSX, hub, capistrano, brew, ant, php, python, etc), over 140 themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community. 

**homebrew**

OS X package manager 

**vim**

Vim is a highly configurable text editor built to enable efficient text editing. It is an improved version of the vi editor distributed with most UNIX system

**vim plugins**

- vundle
- tcomment
- nerdtree
- supertab
- vim-autoformat
- surround.vim
- vim-go
- fugitive
- node vim tools
- vim-easymotion
- vim-colorschemes

