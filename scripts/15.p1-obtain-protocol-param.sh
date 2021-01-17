#!/bin/bash

cd $NODE_HOME

cardano-cli query protocol-parameters \
    --mainnet \
    --allegra-era \
    --out-file params.json

echo Payment address can be funded from your Daedalus / Yoroi wallet.
echo Payment address:$(cat payment.addr)

echo After funding your account, check your payment address balance.
echo Before continuing, your nodes must be fully synchronized to the blockchain.
echo Otherwise, you won't see your funds.

cd -
