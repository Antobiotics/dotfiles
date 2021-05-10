#!/bin/bash

source ./bin/env.sh

ln -sf "${DOTFILES_DIR}"/zsh/.zshrc ~/.zshrc
ln -sf "${DOTFILES_DIR}"/zsh/.aliases ~/.aliases
ln -sf "${DOTFILES_DIR}"/zsh/.p10k.zsh ~/.p10k.zsh
ln -sf "${DOTFILES_DIR}"/zsh/.autosuggestions ~/.autosuggestions
ln -sf "${DOTFILES_DIR}"/zsh/.env ~/.env
ln -sf "${DOTFILES_DIR}"/vim/.vimrc ~/.vimrc
ln -sf "${DOTFILES_DIR}"/nvim ~/.config/nvim
