#!/bin/bash

mkdir $HOME/cold-keys
pushd $HOME/cold-keys

cardano-cli node key-gen \
    --cold-verification-key-file node.vkey \
    --cold-signing-key-file node.skey \
    --operational-certificate-issue-counter node.counter
