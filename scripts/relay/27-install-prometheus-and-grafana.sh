sudo apt-get install -y prometheus prometheus-node-exporter

cd $NODE_HOME/
mkdir grafana
cd grafana

wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

echo "deb https://packages.grafana.com/oss/deb stable main" > grafana.list
sudo mv grafana.list /etc/apt/sources.list.d/grafana.list

sudo apt-get update && sudo apt-get install -y grafana

sudo systemctl enable grafana-server.service
sudo systemctl enable prometheus.service
sudo systemctl enable prometheus-node-exporter.service

#sudo ufw allow from <YOUR IP ADDR> to any port 3000

sed -i ${NODE_CONFIG}-config.json -e "s/127.0.0.1/0.0.0.0/g"
