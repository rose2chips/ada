#!/bin/bash

cd $HOME/cold-keys

rm -f tx.raw
rm -f tx.signed

fromnode.sh $NODE_HOME/tx.raw

cardano-cli transaction sign \
    --tx-body-file tx.raw \
    --signing-key-file payment.skey \
    --signing-key-file node.skey \
    --signing-key-file stake.skey \
    --mainnet \
    --out-file tx.signed

tonode.sh tx.signed $NODE_HOME/
