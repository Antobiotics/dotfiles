#!/bin/bash

set -ex

mkdir -p ~/.config/

source ./bin/env.sh
source ./bin/packages.sh
source ./bin/oh_my_zsh.sh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

git clone https://github.com/supercrabtree/k "$HOME"/.oh-my-zsh/custom/plugins/k
mkdir -p ~/.config/nvim/colors

pip install emoji-fzf
