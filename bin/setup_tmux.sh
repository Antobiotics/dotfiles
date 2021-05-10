#!/bin/bash

source ./bin/env.sh

[ ! -d '.tmux' ] && git clone https://github.com/gpakosz/.tmux.git .tmux
ln -s -f "${DOTFILES_DIR}"/.tmux/.tmux.conf ~/.tmux.conf
ln -s -f "${DOTFILES_DIR}"/tmux/.tmux.conf.local ~/.tmux.conf.local
