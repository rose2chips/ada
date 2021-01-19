#!/bin/bash

cd $HOME/cold-key

cat > poolMetaData.json << EOF
{
    "name": "<NAME>",
    "description": ".{,255}"
    "ticker": "[A-Z0-9]{3,5}",
    "homepage": ""
}
EOF

cardano-cli stake-pool metadata-hash --pool-metadata-file poolMetaData.json > poolMetaDataHash.txt
