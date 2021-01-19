#!/bin/bash

cd $HOME/cold-keys

###
### On air-gapped offline machine,
###
cardano-cli address key-gen \
    --verification-key-file payment.vkey \
    --signing-key-file payment.skey

###
### On air-gapped offline machine,
###
cardano-cli stake-address key-gen \
    --verification-key-file stake.vkey \
    --signing-key-file stake.skey

###
### On air-gapped offline machine,
###
cardano-cli stake-address build \
    --stake-verification-key-file stake.vkey \
    --out-file stake.addr \
    --mainnet

###
### On air-gapped offline machine,
###
cardano-cli address build \
    --payment-verification-key-file payment.vkey \
    --stake-verification-key-file stake.vkey \
    --out-file payment.addr \
    --mainnet

tonode.sh payment.addr $NODE_HOME/
tonode.sh stake.addr $NODE_HOME/
