#!/bin/bash

cd $NODE_HOME

cardano-cli transaction submit \
    --tx-file tx.signed \
    --mainnet
