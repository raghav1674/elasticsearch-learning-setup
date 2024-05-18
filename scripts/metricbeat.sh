#!/usr/bin/env bash

NODE_IP=$(ifconfig eth1 | grep 'inet ' | awk '{print $2}')

export NODE_IP=$NODE_IP

sudo cat /tmp/hosts >> /etc/hosts

sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

sudo tee /etc/yum.repos.d/elasticsearch.repo <<EOF
[metricbeat]
name=Elasticsearch repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=0
autorefresh=1
type=rpm-md
EOF

sudo yum install --enablerepo=metricbeat metricbeat -y

sudo mkdir -p /etc/metricbeat/certs

sudo cp -rf /tmp/certs/*  /etc/metricbeat/certs

# sudo cp /etc/metricbeat/elasticsearch.yml /etc/metricbeat/elasticsearch.yml.old

# envsubst < /tmp/configs/elastic.config.yaml > /tmp/configs/elasticsearch.yml

# sudo cp /tmp/configs/elasticsearch.yml /etc/metricbeat/elasticsearch.yml

# sudo chown -R elasticsearch:elasticsearch /etc/elasticsearch /var/lib/elasticsearch /var/log/elasticsearch 

sudo cp /etc/metricbeat/certs/ca.crt /etc/pki/ca-trust/source/anchors/

sudo update-ca-trust

# sudo systemctl enable elasticsearch

# sudo systemctl start elasticsearch

sudo rm -rf /tmp/elasticsearch
sudo rm -rf /tmp/configs
sudo rm -rf /tmp/certs
sudo rm -rf /tmp/hosts