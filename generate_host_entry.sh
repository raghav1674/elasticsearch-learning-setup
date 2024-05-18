
HOSTS_FILE=hosts
offset=4

for i in $(seq 0 $(( MASTER_NODE_COUNT - 1))); do
  echo "${MASTER_NETWORK_RANGE}$(printf '%d' $((offset + i))) ${VM_PREFIX}master$i.example.local" >> ${HOSTS_FILE}
done

if [ "$HOT_DATA_NODE_COUNT" -ne 0 ]; then
    for i in $(seq 0 $(( $HOT_DATA_NODE_COUNT -1))); do
    echo "${HOT_DATA_NETWORK_RANGE}$(printf '%d' $((offset + i))) ${VM_PREFIX}hot$i.example.local" >> ${HOSTS_FILE}
    done
fi

if [ "$WARM_DATA_NODE_COUNT" -ne 0 ]; then
    for i in $(seq 0 $(( $WARM_DATA_NODE_COUNT -1))); do
    echo "${WARM_DATA_NETWORK_RANGE}$(printf '%d' $((offset + i))) ${VM_PREFIX}warm$i.example.local" >> ${HOSTS_FILE}
    done
fi

echo "${KIBANA_NETWORK_RANGE}${offset} ${VM_PREFIX}kibana.example.local" >> ${HOSTS_FILE}

cat ${HOSTS_FILE}
