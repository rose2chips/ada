#!/bin/bash

cd $NODE_HOME

if ! [ -d backup ]; then
  mkdir backup
fi

mv kes.vkey backup/
mv kes.skey backup/
mv node.cert backup/

cardano-cli node key-gen-KES \
    --verification-key-file kes.vkey \
    --signing-key-file kes.skey

slotsPerKESPeriod=$(cat $NODE_HOME/${NODE_CONFIG}-shelley-genesis.json | jq -r '.slotsPerKESPeriod')
echo slotsPerKESPeriod: ${slotsPerKESPeriod}

slotNo=$(cardano-cli query tip --mainnet | jq -r '.slotNo')
echo slotNo: ${slotNo}

kesPeriod=$((${slotNo} / ${slotsPerKESPeriod}))
startKesPeriod=${kesPeriod}
echo startKesPeriod: ${startKesPeriod}

cat > $NODE_HOME/gen-op-cert.sh << EOF
cd \$HOME/cold-keys

if ! [ -d backup ]; then
  mkdir backup
fi

mv kes.vkey backup/
mv kes.skey backup/
mv node.cert backup/

fromnode.sh $NODE_HOME/kes.vkey
fromnode.sh $NODE_HOME/kes.skey
fromnode.sh $NODE_HOME/gen-op-cert.sh

cardano-cli node issue-op-cert \\
    --kes-verification-key-file kes.vkey \\
    --cold-signing-key-file node.skey \\
    --operational-certificate-issue-counter node.counter \\
    --kes-period ${startKesPeriod} \\
    --out-file node.cert

tonode.sh node.cert $NODE_HOME/

echo "Be sure to BACK UP ALL your KEYS to another secure storage device."
echo "Make MULTIPLE COPIES."
EOF

chmod a+x $NODE_HOME/gen-op-cert.sh
