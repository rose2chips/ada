sudo apt-get install -y prometheus-node-exporter 

sudo systemctl enable prometheus-node-exporter.service

#sudo ufw allow from <IP ADDR of relay node> to any port 12798
#sudo ufw allow from <IP ADDR of relay node>  to any port 9100
#sudo ufw allow from <IP ADDR of relay node>  to any port 9091

cd $NODE_HOME

sed -i ${NODE_CONFIG}-config.json -e "s/127.0.0.1/0.0.0.0/g"
