#!/bin/bash

cd $NODE_HOME

cardano-cli query protocol-parameters \
    --mainnet \
    --allegra-era \
    --out-file params.json
