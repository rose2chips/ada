#!/bin/bash

mkdir -p $HOME/ada/setup
cd $HOME/ada/setup

git clone https://github.com/input-output-hk/libsodium

cd libsodium
git checkout 66f017f1
./autogen.sh
./configure
make
sudo make install

cd -
