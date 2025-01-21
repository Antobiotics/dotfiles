#!/bin/bash

set -ex

mkdir -p ~/.config/
mkdir -p ~/.config/nvim/colors

source ./bin/env.sh
source ./bin/packages.sh
source ./bin/env.sh

curl -sSf https://rye.astral.sh/get | bash
pip install emoji-fzf
