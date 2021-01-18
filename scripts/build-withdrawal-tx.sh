#!/bin/bash

USAGE="$0 <amount in lovelace> <address of receiver>"

if [ "$1" = "" ]; then
    echo $USAGE
    exit
fi

if [ "$2" = "" ]; then
    echo $USAGE
    exit
fi

requestedWithdrawal="$1"
recipientAddress="$2"

cd $NODE_HOME

rm -f $NODE_HOME/tx.tmp
rm -f $NODE_HOME/tx.raw
rm -f $NODE_HOME/tx.signed

# You need to find the tip of the blockchain to set the invalid-hereafter parameter properly.
currentSlot=$(cardano-cli query tip --mainnet | jq -r '.slotNo')
echo Current Slot: $currentSlot

# Find your balance and UTXOs.
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
echo Number of UTXOs: ${txcnt}

echo Total ADA balance: ${total_balance}
echo Requested Amount: ${requestedWithdrawal}
echo Recipient Address: ${recipientAddress}

# Run the build-raw transaction command.
cardano-cli transaction build-raw \
    ${tx_in} \
    --tx-out ${recipientAddress}+0 \
    --tx-out $(cat payment.addr)+0 \
    --invalid-hereafter $(( ${currentSlot} + 10000)) \
    --fee 0 \
    --out-file tx.tmp \
    --allegra-era \

# Calculate the current minimum fee
fee=$(cardano-cli transaction calculate-min-fee \
    --tx-body-file tx.tmp \
    --tx-in-count ${txcnt} \
    --tx-out-count 2 \
    --mainnet \
    --witness-count 2 \
    --byron-witness-count 0 \
    --protocol-params-file params.json | awk '{ print $1 }')
echo fee: $fee

# Calculate your change output.
txOut=$((${total_balance}-${requestedWithdrawal}-${fee}))
echo Change Output: ${txOut}

# Build your transaction
cardano-cli transaction build-raw \
    ${tx_in} \
    --tx-out ${recipientAddress}+${requestedWithdrawal} \
    --tx-out $(cat payment.addr)+${txOut} \
    --invalid-hereafter $(( ${currentSlot} + 10000)) \
    --fee ${fee} \
    --allegra-era \
    --out-file tx.raw
