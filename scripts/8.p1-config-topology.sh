#!/bin/bash

cat > $NODE_HOME/${NODE_CONFIG}-topology.json << EOF 
 {
    "Producers": [
      {
        "addr": "138.68.49.251",
        "port": 6000,
        "valency": 1
      }
    ]
  }
EOF
