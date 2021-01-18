#!/bin/bash

cd $NODE_HOME

cat > poolMetaData.json << EOF
{
    "name": "<NAME>",
    "description": ".{,255}"
    "ticker": "[A-Z0-9]{3,5}",
    "homepage": ""
}
EOF

cardano-cli stake-pool metadata-hash --pool-metadata-file poolMetaData.json > poolMetaDataHash.txt

minPoolCost=$(cat $NODE_HOME/params.json | jq -r .minPoolCost)
echo minPoolCost: ${minPoolCost}

cd - > /dev/null
