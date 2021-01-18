#!/bin/bash

cd $NODE_HOME

cardano-cli query stake-address-info \
 --address $(cat stake.addr) \
 --allegra-era \
 --mainnet
