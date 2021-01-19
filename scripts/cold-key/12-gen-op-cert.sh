#!/bin/bash

cd $HOME/cold-key

fromnode.sh $NODE_HOME/gen-op-cert.sh

chmod a+x gen-op-cert.sh
./gen-op-cert.sh
