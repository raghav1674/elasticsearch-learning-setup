#!/usr/bin/env bash

ELASTICSEARCH_HOSTS=$1
KIBANA_TOKEN=$2
NODE_IP=$(ifconfig eth1 | grep 'inet ' | awk '{print $2}')

export ELASTICSEARCH_HOSTS=$ELASTICSEARCH_HOSTS
export KIBANA_TOKEN=$KIBANA_TOKEN
export NODE_IP=$NODE_IP

sudo cat /tmp/hosts >> /etc/hosts

sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

sudo tee /etc/yum.repos.d/elasticsearch.repo <<EOF
[elasticsearch]
name=Elasticsearch repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=0
autorefresh=1
type=rpm-md
EOF

sudo yum install --enablerepo=elasticsearch kibana -y

sudo mkdir -p /etc/kibana/certs

sudo cp -rf /tmp/certs/*  /etc/kibana/certs

sudo cp /etc/kibana/kibana.yml /etc/kibana/kibana.yml.old

envsubst < /tmp/configs/kibana.config.yaml > /tmp/configs/kibana.yml

sudo cp /tmp/configs/kibana.yml /etc/kibana/kibana.yml

sudo chown -R kibana:kibana /etc/kibana /var/lib/kibana /var/log/kibana 

sudo cp /etc/kibana/certs/ca.crt /etc/pki/ca-trust/source/anchors/

sudo update-ca-trust

sudo systemctl enable kibana

sudo systemctl start kibana

sudo rm -rf /tmp/kibana
sudo rm -rf /tmp/configs
sudo rm -rf /tmp/certs
sudo rm -rf /tmp/hosts