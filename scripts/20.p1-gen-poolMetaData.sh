#!/bin/bash

cd $NODE_HOME

cat > poolMetaData.json << EOF
{
    "name": "MayHoney Private",
    "description": "The private pool of MayHoney Lab.",
    "ticker": "MHL01",
    "homepage": "http://mayhoney.co.kr"
}
EOF

cardano-cli stake-pool metadata-hash --pool-metadata-file poolMetaData.json > poolMetaDataHash.txt

minPoolCost=$(cat $NODE_HOME/params.json | jq -r .minPoolCost)
echo minPoolCost: ${minPoolCost}

cd -
