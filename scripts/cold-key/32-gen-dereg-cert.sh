#!/bin/bash

if [ "$1" = "" ]; then
  echo $0 [retirement epoch]
  exit
fi

cd $HOME/cold-keys

cardano-cli stake-pool deregistration-certificate \
--cold-verification-key-file node.vkey \
--epoch $1 \
--out-file pool.dereg

tonode.sh pool.dereg $NODE_HOME/
