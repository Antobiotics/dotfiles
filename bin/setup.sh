#!/bin/bash

source ./env.sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew bundle

git clone https://github.com/supercrabtree/k "$HOME"/.oh-my-zsh/custom/plugins/k

mkdir -p ~/.config/

mkdir -p ~/.config/nvim/colors
curl -o ~/.config/nvim/colors/toast.vim https://raw.githubusercontent.com/jsit/toast.vim/master/colors/toast.vim
