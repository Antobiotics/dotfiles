#!/bin/bash

set -ex

source ./bin/env.sh

[ ! -d "${HOME}/.tmux" ] && git clone https://github.com/gpakosz/.tmux.git "${HOME}/.tmux"
ln -s -f "${HOME}/.tmux/.tmux.conf" "${HOME}/.tmux.conf"
ln -s -f "${DOTFILES_DIR}/tmux/.tmux.conf.local" "${HOME}/.tmux.conf.local"
