#!/bin/bash

cd $HOME/cold-keys

cardano-cli stake-pool id --cold-verification-key-file node.vkey --output-format hex > stakepoolid.txt
cat stakepoolid.txt

toproducer.sh stakepoolid.txt ada/cardano-node

cd - > /dev/null
