#!/usr/bin/env bash

CLUSTER_NAME=$1
NODE_ROLES=$2
MASTER_SEED_HOSTS=$3
BOOTSTRAP_PASSWORD=$4
NODE_IP=$(ifconfig eth1 | grep 'inet ' | awk '{print $2}')

echo $CLUSTER_NAME
echo $NODE_ROLES
echo $MASTER_SEED_HOSTS
echo $BOOTSTRAP_PASSWORD


export CLUSTER_NAME=$CLUSTER_NAME
export NODE_ROLES=$NODE_ROLES
export MASTER_SEED_HOSTS=$MASTER_SEED_HOSTS
export BOOTSTRAP_PASSWORD=$BOOTSTRAP_PASSWORD
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

sudo yum install --enablerepo=elasticsearch elasticsearch -y

sudo echo "elastic" | /usr/share/elasticsearch/bin/elasticsearch-keystore add -x 'bootstrap.password'

sudo mkdir -p /etc/elasticsearch/certs

sudo cp -rf /tmp/certs/*  /etc/elasticsearch/certs

sudo cp /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.old

envsubst < /tmp/configs/elastic.config.yaml > /tmp/configs/elasticsearch.yml

sudo cp /tmp/configs/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

sudo chown -R elasticsearch:elasticsearch /etc/elasticsearch /var/lib/elasticsearch /var/log/elasticsearch 

sudo cp /etc/elasticsearch/certs/ca.crt /etc/pki/ca-trust/source/anchors/

sudo update-ca-trust

sudo tee /etc/security/limits.conf <<EOF
elasticsearch soft memlock unlimited
elasticsearch hard memlock unlimited
EOF

sudo systemctl enable elasticsearch

sudo systemctl start elasticsearch

sudo rm -rf /tmp/elasticsearch
sudo rm -rf /tmp/configs
sudo rm -rf /tmp/certs
sudo rm -rf /tmp/hosts