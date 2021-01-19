#!/bin/bash

cd $NODE_HOME

cardano-cli node key-gen-VRF \
    --verification-key-file vrf.vkey \
    --signing-key-file vrf.skey

chmod 400 vrf.skey
