curl --noproxy '*' -X DELETE http://localhost:8083/connectors/01-formatted-connector

curl --noproxy '*' -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @./01-sink-connector.json
