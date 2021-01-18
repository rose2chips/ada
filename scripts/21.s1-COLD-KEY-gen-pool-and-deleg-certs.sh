#!/bin/bash

cd $HOME/cold-keys

fromproducer.sh ada/cardano-node/vrf.vkey
fromproducer.sh ada/cardano-node/vrf.skey
fromproducer.sh ada/cardano-node/poolMetaDataHash.txt

cardano-cli stake-pool registration-certificate \
    --cold-verification-key-file node.vkey \
    --vrf-verification-key-file vrf.vkey \
    --pool-pledge 100000000 \
    --pool-cost 345000000 \
    --pool-margin 0.15 \
    --pool-reward-account-verification-key-file stake.vkey \
    --pool-owner-stake-verification-key-file stake.vkey \
    --mainnet \
    --single-host-pool-relay <HOST NAME> \
    --pool-relay-port 6000 \
    --metadata-url https://github.com/rose2chips/ada/blob/main/poolMetaData.json \
    --metadata-hash $(cat poolMetaDataHash.txt) \
    --out-file pool.cert

cardano-cli stake-address delegation-certificate \
    --stake-verification-key-file stake.vkey \
    --cold-verification-key-file $HOME/cold-keys/node.vkey \
    --out-file deleg.cert

toproducer.sh pool.cert ada/cardano-node
toproducer.sh deleg.cert ada/cardano-node

cd - > /dev/null
