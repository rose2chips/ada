#!/bin/bash

mkdir -p $HOME/ada/setup/ghc
cd $HOME/ada/setup/ghc

rm -rf ghc-8.10.2

if ! [ -f ghc-8.10.2-x86_64-deb9-linux.tar.xz ]; then
  wget https://downloads.haskell.org/ghc/8.10.2/ghc-8.10.2-x86_64-deb9-linux.tar.xz
fi

tar -xf ghc-8.10.2-x86_64-deb9-linux.tar.xz
#rm ghc-8.10.2-x86_64-deb9-linux.tar.xz

cd ghc-8.10.2
./configure
sudo make install

cabal update
cabal -V
ghc -V
