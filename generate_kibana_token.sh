#!/usr/bin/env bash

curl -XPOST https://${VM_PREFIX}master0.example.local:9200/_security/service/elastic/kibana/credential/token/sa -u "elastic:${BOOTSTRAP_PASSWORD}" -k


