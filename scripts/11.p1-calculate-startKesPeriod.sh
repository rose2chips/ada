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
#echo ${startKesPeriod} > $NODE_HOME/startKesPeriod

cat > $HOME/ada/setup/12.s2-gen-op-cert.sh << EOF
#pushd $HOME/cold-keys
cd \$HOME/cold-keys

rm -f kes.vkey
rm -f kes.skey

fromproducer.sh ada/cardano-node/kes.vkey
fromproducer.sh ada/cardano-node/kes.skey

cardano-cli node issue-op-cert \\
    --kes-verification-key-file kes.vkey \\
    --cold-signing-key-file node.skey \\
    --operational-certificate-issue-counter node.counter \\
    --kes-period ${startKesPeriod} \\
    --out-file node.cert

toproducer.sh node.cert ada/cardano-node/

echo "Be sure to BACK UP ALL your KEYS to another secure storage device."
echo "Make MULTIPLE COPIES."
EOF

chmod a+x $HOME/ada/setup/12.s2-gen-op-cert.sh

