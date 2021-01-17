#!/bin/bash

cd $NODE_HOME

cardano-cli query utxo \
    --address $(cat payment.addr) \
    --allegra-era \
    --mainnet

cd -
