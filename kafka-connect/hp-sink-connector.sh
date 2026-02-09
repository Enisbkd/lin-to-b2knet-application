curl --noproxy '*' -X DELETE http://localhost:8083/connectors/hp-formatted-connector

curl --noproxy '*' -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @./hp-sink-connector.json
