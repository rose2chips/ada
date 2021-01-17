#!/bin/bash

cat > $NODE_HOME/${NODE_CONFIG}-topology.json << EOF 
 {
    "Producers": [
      {
        "addr": "<IP ADDR>",
        "port": 6000,
        "valency": 1
      }
    ]
  }
EOF
