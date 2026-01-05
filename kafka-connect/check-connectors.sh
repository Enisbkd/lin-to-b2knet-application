#!/bin/bash

echo "=== Kafka Connect Status ==="
curl --noproxy '*' -s http://localhost:8083/ | jq .

echo ""
echo "=== Available Connector Plugins ==="
curl --noproxy '*' -s http://localhost:8083/connector-plugins | jq '.[].class'

echo ""
echo "=== Active Connectors ==="
CONNECTORS=$(curl --noproxy '*' -s http://localhost:8083/connectors)
echo $CONNECTORS | jq .

echo ""
echo "=== Connector Details ==="
for connector in $(echo $CONNECTORS | jq -r '.[]'); do
    echo "--- $connector ---"
    curl --noproxy '*' -s "http://localhost:8083/connectors/$connector/status" | jq '{name: .name, state: .connector.state, worker: .connector.worker_id, tasks: [.tasks[] | {id: .id, state: .state}]}'
    echo ""
done