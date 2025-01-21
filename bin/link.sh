#!/bin/bash

set -ex

source ./bin/env.sh

mkdir -p "${HOME}"/.config

ln -sf "${DOTFILES_DIR}/alacritty/alacritty.yml" "${HOME}/.config/alacritty.yml"
ln -sf "${DOTFILES_DIR}/kitty" "${HOME}/.config"
ln -sf "${DOTFILES_DIR}/zsh/.zshrc" "${HOME}/.zshrc"
ln -sf "${DOTFILES_DIR}/zsh/.aliases" "${HOME}/.aliases"
ln -sf "${DOTFILES_DIR}/zsh/.p10k.zsh" "${HOME}/.p10k.zsh"
ln -sf "${DOTFILES_DIR}/zsh/.autosuggestions" "${HOME}/.autosuggestions"
ln -sf "${DOTFILES_DIR}/zsh/.env" "${HOME}/.env"
ln -sf "${DOTFILES_DIR}/vim/.vimrc" "${HOME}/.vimrc"
ln -sf "${DOTFILES_DIR}/nvim" "${HOME}/.config"
