#!/bin/bash

cd $NODE_HOME

cardano-cli query ledger-state --mainnet --allegra-era | grep publicKey | grep $(cat stakepoolid.txt)

cd -
