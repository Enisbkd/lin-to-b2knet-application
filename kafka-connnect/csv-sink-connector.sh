curl --noproxy '*' -X DELETE http://localhost:8083/connectors/csv-formatted-connector

curl --noproxy '*' -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @csv-sink-connector.json