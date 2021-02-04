#!/bin/bash

cd $NODE_HOME

rm -f $NODE_HOME/tx.tmp
rm -f $NODE_HOME/tx.raw
rm -f $NODE_HOME/tx.signed

cardano-cli query utxo \
    --address $(cat payment.addr) \
    --allegra-era \
    --mainnet > fullUtxo.out

tail -n +3 fullUtxo.out | sort -k3 -nr > balance.out

cat balance.out

tx_in=""
total_balance=0
while read -r utxo; do
    in_addr=$(awk '{ print $1 }' <<< "${utxo}")
    idx=$(awk '{ print $2 }' <<< "${utxo}")
    utxo_balance=$(awk '{ print $3 }' <<< "${utxo}")
    total_balance=$((${total_balance}+${utxo_balance}))
    echo TxHash: ${in_addr}#${idx}
    echo ADA: ${utxo_balance}
    tx_in="${tx_in} --tx-in ${in_addr}#${idx}"
done < balance.out
txcnt=$(cat balance.out | wc -l)
echo Total ADA balance: ${total_balance}
echo Number of UTXOs: ${txcnt}

slotNo=$(cardano-cli query tip --mainnet | jq -r '.slotNo')
echo slotNo: ${slotNo}

cardano-cli transaction build-raw \
    ${tx_in} \
    --tx-out $(cat payment.addr)+${total_balance} \
    --invalid-hereafter $(( ${slotNo} + 10000)) \
    --fee 0 \
    --certificate-file pool.dereg \
    --allegra-era \
    --out-file tx.tmp

fee=$(cardano-cli transaction calculate-min-fee \
    --tx-body-file tx.tmp \
    --tx-in-count ${txcnt} \
    --tx-out-count 1 \
    --mainnet \
    --witness-count 2 \
    --byron-witness-count 0 \
    --protocol-params-file params.json | awk '{ print $1 }')
echo fee: $fee

txOut=$((${total_balance}-${fee}))
echo txOut: ${txOut}

cardano-cli transaction build-raw \
    ${tx_in} \
    --tx-out $(cat payment.addr)+${txOut} \
    --invalid-hereafter $(( ${slotNo} + 10000)) \
    --fee ${fee} \
    --certificate-file pool.dereg \
    --allegra-era \
    --out-file tx.raw
