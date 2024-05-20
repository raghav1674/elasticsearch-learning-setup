
```
./generate_certificates.sh

source .env.dc

./generate_host_entry.sh

source .env.dr

./generate_host_entry.sh
```


Setup DC Elasticsearch

```
source .env.dc

vagrant up master0 --provision

vagrant up hot0 --provision

vagrant up warm0 --provision

./generate_kibana_token.sh

Update the value of kibana token in .env.dc

source .env.dc

vagrant up kibana --provision
```



Setup DR Elasticsearch

```
source .env.dr

vagrant up drmaster0 --provision

vagrant up drhot0 --provision

vagrant up drwarm0 --provision

./generate_kibana_token.sh

Update the value of kibana token in .env.dr

source .env.dr

vagrant up drkibana --provision
```
