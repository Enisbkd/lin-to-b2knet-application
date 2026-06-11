curl --noproxy '*' -X DELETE http://localhost:8083/connectors/02-formatted-connector

curl --noproxy '*' -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @./02-sink-connector.json
