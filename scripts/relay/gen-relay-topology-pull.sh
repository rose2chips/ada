#!/bin/bash

###
### On relaynode1
###
cat > $NODE_HOME/relay-topology-pull.sh << EOF
#!/bin/bash
BLOCKPRODUCING_IP="<IP ADDR>"
BLOCKPRODUCING_PORT=6000
curl -s -o $NODE_HOME/${NODE_CONFIG}-topology.json "https://api.clio.one/htopology/v1/fetch/?max=20&customPeers=\${BLOCKPRODUCING_IP}:\${BLOCKPRODUCING_PORT}:2|relays-new.cardano-mainnet.iohk.io:3001:2"
EOF

chmod +x $NODE_HOME/relay-topology-pull.sh
#$NODE_HOME/relay-topology-pull.sh

# Add a crontab job to automatically run relay-topology-pull.sh
cat > crontab-fragment.txt << EOF
50 23 * * * ${NODE_HOME}/relay-topology-pull.sh
EOF

#crontab -l | cat - crontab-fragment.txt >crontab.txt && crontab crontab.txt
#rm crontab-fragment.txt
crontab -l | cat - crontab-fragment.txt > crontab.txt

cat > $NODE_HOME/restart-node.sh << EOF
#!/bin/bash
systemctl restart cardano-node
EOF

chmod +x $NODE_HOME/restart-node.sh

# Add a crontab job to automatically run relay-topology-pull.sh
cat > crontab-sudo-fragment.txt << EOF
00 00 * * * ${NODE_HOME}/restart-node.sh
EOF
sudo crontab -l | cat - crontab-sudo-fragment.txt > crontab-sudo.txt
