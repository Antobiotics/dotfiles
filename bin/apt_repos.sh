#!/bin/bash

set -ex

echo "Setup repositories"

# alacritty
sudo add-apt-repository ppa:aslatter/ppa

# neovim
sudo add-apt-repository ppa:neovim-ppa/unstable

sudo apt update

sudo -k
