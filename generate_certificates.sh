openssl genrsa  -out certs/ca.key 2048
openssl req -x509 -new -nodes -key certs/ca.key -sha256 -days 1825 -out certs/ca.crt -subj "/CN=ca.example.local"


openssl genrsa -out certs/elasticsearch.key 2048
openssl req -new -key certs/elasticsearch.key -out certs/elasticsearch.csr -subj "/CN=*.example.local" 

tee certs/elasticsearch.ext <<EOF
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no

[req_distinguished_name]
C = IN
ST = elastic
L = elastic
O = elastic
OU = elastic
CN = *.example.local

[v3_req]
extendedKeyUsage = serverAuth, clientAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = *.example.local
EOF

openssl x509 -req -in certs/elasticsearch.csr -CA certs/ca.crt -CAkey certs/ca.key -CAcreateserial -out certs/elasticsearch.crt -days 1825 -sha256 -extfile certs/elasticsearch.ext -extensions v3_req