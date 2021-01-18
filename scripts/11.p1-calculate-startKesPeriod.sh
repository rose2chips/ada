#!/bin/bash

#pushd +1
slotsPerKESPeriod=$(cat $NODE_HOME/${NODE_CONFIG}-shelley-genesis.json | jq -r '.slotsPerKESPeriod')
echo slotsPerKESPeriod: ${slotsPerKESPeriod}

slotNo=$(cardano-cli query tip --mainnet | jq -r '.slotNo')
echo slotNo: ${slotNo}

kesPeriod=$((${slotNo} / ${slotsPerKESPeriod}))
#echo kesPeriod: ${kesPeriod}
startKesPeriod=${kesPeriod}
echo startKesPeriod: ${startKesPeriod}

cat > $HOME/ada/setup/12.s2-gen-op-cert.sh << EOF
fromproducer.sh ada/cardano-node/kes.vkey $HOME/cold-keys/
fromproducer.sh ada/cardano-node/startKesPeriod $HOME/ada/setup/

pushd $HOME/cold-keys

cardano-cli node issue-op-cert \\
    --kes-verification-key-file kes.vkey \\
    --cold-signing-key-file $HOME/cold-keys/node.skey \\
    --operational-certificate-issue-counter $HOME/cold-keys/node.counter \\
    --kes-period ${startKesPeriod} \\
    --out-file node.cert

toproducer.sh $HOME/cold-keys/node.cert ada/cardano-node/

echo "Be sure to BACK UP ALL your KEYS to another secure storage device."
echo "Make MULTIPLE COPIES."
EOF

chmod a+x $HOME/ada/setup/12.s2-gen-op-cert.sh

