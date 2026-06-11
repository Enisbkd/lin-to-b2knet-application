curl --noproxy '*' -X DELETE http://localhost:8083/connectors/03-formatted-connector

curl --noproxy '*' -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @03-sink-connector.json
