#!/bin/bash

cd $HOME/cold-keys

fromproducer.sh ada/cardano-node/tx.raw

cardano-cli transaction sign \
    --tx-body-file tx.raw \
    --signing-key-file payment.skey \
    --signing-key-file stake.skey \
    --mainnet \
    --out-file tx.signed

toproducer.sh tx.signed ada/cardano-node/

cd - > /dev/null
