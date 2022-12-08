#!/bin/bash

set -ex

mkdir -p ~/.config/

source ./bin/env.sh
source ./bin/packages.sh
source ./bin/oh_my_zsh.sh


git clone https://github.com/supercrabtree/k "$HOME"/.oh-my-zsh/custom/plugins/k
mkdir -p ~/.config/nvim/colors

pip install emoji-fzf
