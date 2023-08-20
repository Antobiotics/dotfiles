#!/bin/bash

set -ex

platform=$(uname)

if [[ "$platform" == "Linux" ]]; then
    # source ./bin/apt_repos.sh

    echo "Installing required packages"
    # xargs sudo apt-get install -y < apt_file

    echo "Leaving sudo"
    # sudo -k
else
    # In that case we are using mac os
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew bundle
fi
