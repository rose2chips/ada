#!/bin/bash

cd $HOME/cold-keys

cardano-cli stake-pool registration-certificate \
    --cold-verification-key-file node.vkey \
    --vrf-verification-key-file vrf.vkey \
    --pool-pledge 100000000 \
    --pool-cost 340000000 \
    --pool-margin 1.00 \
    --pool-reward-account-verification-key-file stake.vkey \
    --pool-owner-stake-verification-key-file stake.vkey \
    --mainnet \
    --single-host-pool-relay <HOST NAME> \
    --pool-relay-port 6000 \
    --metadata-url <URL> \
    --metadata-hash $(cat poolMetaDataHash.txt) \
    --out-file pool.cert

cardano-cli stake-address delegation-certificate \
    --stake-verification-key-file stake.vkey \
    --cold-verification-key-file node.vkey \
    --out-file deleg.cert

tonode.sh pool.cert $NODE_HOME/
tonode.sh deleg.cert $NODE_HOME/
