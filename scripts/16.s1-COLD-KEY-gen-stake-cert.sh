#!/bin/bash

cd $HOME/cold-keys

###
### On air-gapped offline machine,
###
cardano-cli stake-address registration-certificate \
    --stake-verification-key-file stake.vkey \
    --out-file stake.cert

toproducer.sh stake.cert ada/cardano-node/
