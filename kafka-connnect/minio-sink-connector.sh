curl --noproxy '*' -X DELETE http://localhost:8083/connectors/models-formatted-connector

curl --noproxy '*' -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @minio-sink-connector.json