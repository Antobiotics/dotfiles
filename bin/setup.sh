#!/bin/bash

set -ex

mkdir -p ~/.config/
mkdir -p ~/.config/nvim/colors

source ./bin/env.sh
source ./bin/packages.sh
source ./bin/oh_my_zsh.sh
source ./bin/env.sh


if [[ "$OSTYPE" == "darwin"* ]]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	brew bundle
fi

git clone https://github.com/supercrabtree/k "$HOME"/.oh-my-zsh/custom/plugins/k
pip install emoji-fzf
