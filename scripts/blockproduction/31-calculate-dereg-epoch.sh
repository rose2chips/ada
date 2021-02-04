#!/bin/bash

cd $NODE_HOME
rm pool.dereg

startTimeGenesis=$(cat $NODE_HOME/${NODE_CONFIG}-shelley-genesis.json | jq -r .systemStart)
startTimeSec=$(date --date=${startTimeGenesis} +%s)
currentTimeSec=$(date -u +%s)
epochLength=$(cat $NODE_HOME/${NODE_CONFIG}-shelley-genesis.json | jq -r .epochLength)
epoch=$(( (${currentTimeSec}-${startTimeSec}) / ${epochLength} ))
echo current epoch: ${epoch}

eMax=$(cat $NODE_HOME/params.json | jq -r '.eMax')
echo eMax: ${eMax}

minRetirementEpoch=$(( ${epoch} + 1 ))
maxRetirementEpoch=$(( ${epoch} + ${eMax} ))

echo earliest epoch for retirement is: ${minRetirementEpoch}
echo latest epoch for retirement is: ${maxRetirementEpoch}
