#!/bin/bash

if [ "$1" = "" ]; then
    echo "$0 (start|stop)"
    exit
fi

sudo systemctl $1 cardano-node

# View the status of the node service
#sudo systemctl status cardano-node

# Restarting the node service
#sudo systemctl reload-or-restart cardano-node

# Stopping the node service
#sudo systemctl stop cardano-node

# Viewing and filter logs
#journalctl --unit=cardano-node --follow
#journalctl --unit=cardano-node --since=yesterday
#journalctl --unit=cardano-node --since=today
#journalctl --unit=cardano-node --since='2020-07-29 00:00:00' --until='2020-07-29 12:00:00'
