#!/bin/bash

cd $HOME/cold-keys

rm -f tx.raw
rm -f tx.signed

fromproducer.sh ada/cardano-node/tx.raw

cardano-cli transaction sign \
    --tx-body-file tx.raw \
    --signing-key-file payment.skey \
    --mainnet \
    --out-file tx.signed

toproducer.sh tx.signed ada/cardano-node
