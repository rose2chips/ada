#!/bin/bash

mkdir -p $HOME/ada/setup/cabal
cd $HOME/ada/setup/cabal

wget https://downloads.haskell.org/~cabal/cabal-install-3.2.0.0/cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
tar -xf cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
#rm cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz cabal.sig
rm cabal.sig

mkdir -p $HOME/ada/bin
mv cabal $HOME/ada/bin/
#sudo mv cabal /usr/local/bin/

cd -
