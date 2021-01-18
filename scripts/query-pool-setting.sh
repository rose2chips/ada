#!/bin/bash

cd $NODE_HOME

cardano-cli query ledger-state --mainnet --allegra-era --out-file ledger-state.json
jq -r '.esLState._delegationState._pstate._pParams."'"$(cat stakepoolid.txt)"'"  // empty' ledger-state.json

cd - > /dev/null
