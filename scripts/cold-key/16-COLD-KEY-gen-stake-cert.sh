#!/bin/bash

cd $HOME/cold-keys

###
### On air-gapped offline machine,
###
cardano-cli stake-address registration-certificate \
    --stake-verification-key-file stake.vkey \
    --out-file stake.cert

tonode.sh stake.cert $NODE_HOME/
