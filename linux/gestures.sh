#!/bin/bash

set -ex

sudo gpasswd -a $USER input

install_dir=$HOME/dev/third_party
mkdir -p "$install_dir"

lib_dest=$install_dir/libinput-gestures

[ -d $lib_dest ] && rm -rf $lib_dest
git clone https://github.com/bulletmark/libinput-gestures.git $lib_dest

cd $lib_dest || exit 1
sudo make install
sudo ./libinput-gestures-setup install

cd - || exit 1

gestures_dest=$install_dir/gestures
[ -d $gestures_dest ] && rm -rf $gestures_dest
git clone https://gitlab.com/cunidev/gestures $gestures_dest

cd $gestures_dest || exit 1
meson build --prefix=/usr
ninja -C build
sudo ninja -C build install

cd - || exit 1
