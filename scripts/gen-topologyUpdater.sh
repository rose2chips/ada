#!/bin/bash

###
### On relaynode1
###
cat > $NODE_HOME/topologyUpdater.sh << EOF
#!/bin/bash
# shellcheck disable=SC2086,SC2034
 
#USERNAME=$(whoami)
CNODE_PORT=6000 # must match your relay node port as set in the startup command
CNODE_HOSTNAME="CHANGE ME"  # optional. must resolve to the IP you are requesting from
#CNODE_BIN="/usr/local/bin"
#CNODE_HOME=$NODE_HOME
#CNODE_LOG_DIR="\${CNODE_HOME}/logs"
#GENESIS_JSON="\${CNODE_HOME}/${NODE_CONFIG}-shelley-genesis.json"
CNODE_LOG_DIR="${NODE_HOME}/logs"
GENESIS_JSON="${NODE_HOME}/${NODE_CONFIG}-shelley-genesis.json"
NETWORKID=\$(jq -r .networkId \$GENESIS_JSON)
CNODE_VALENCY=1   # optional for multi-IP hostnames
NWMAGIC=\$(jq -r .networkMagic < \$GENESIS_JSON)
[[ "\${NETWORKID}" = "Mainnet" ]] && HASH_IDENTIFIER="--mainnet" || HASH_IDENTIFIER="--testnet-magic \${NWMAGIC}"
[[ "\${NWMAGIC}" = "764824073" ]] && NETWORK_IDENTIFIER="--mainnet" || NETWORK_IDENTIFIER="--testnet-magic \${NWMAGIC}"
 
#export PATH="\${CNODE_BIN}:\${PATH}"
#export CARDANO_NODE_SOCKET_PATH="\${CNODE_HOME}/db/socket"
export CARDANO_NODE_SOCKET_PATH="${NODE_HOME}/db/socket"
 
blockNo=\$(/usr/local/bin/cardano-cli query tip \${NETWORK_IDENTIFIER} | jq -r .blockNo )
 
# Note:
# if you run your node in IPv4/IPv6 dual stack network configuration and want announced the
# IPv4 address only please add the -4 parameter to the curl command below  (curl -4 -s ...)
if [ "\${CNODE_HOSTNAME}" != "CHANGE ME" ]; then
  T_HOSTNAME="&hostname=\${CNODE_HOSTNAME}"
else
  T_HOSTNAME=''
fi

if [ ! -d \${CNODE_LOG_DIR} ]; then
  mkdir -p \${CNODE_LOG_DIR};
fi
 
curl -s "https://api.clio.one/htopology/v1/?port=\${CNODE_PORT}&blockNo=\${blockNo}&valency=\${CNODE_VALENCY}&magic=\${NWMAGIC}\${T_HOSTNAME}" | tee -a \$CNODE_LOG_DIR/topologyUpdater_lastresult.json
EOF

chmod +x $NODE_HOME/topologyUpdater.sh
#$NODE_HOME//topologyUpdater.sh

# Add a crontab job to automatically run topologyUpdater.sh
# every hour on the 22nd minute.
cat > crontab-fragment.txt << EOF
36 * * * * ${NODE_HOME}/topologyUpdater.sh
EOF

#crontab -l | cat - crontab-fragment.txt >crontab.txt && crontab crontab.txt
#rm crontab-fragment.txt
