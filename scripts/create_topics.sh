#!/bin/bash
set -e

KAFKA_CONTAINER="kafka"
BOOTSTRAP_SERVER="localhost:9092"
PARTITIONS=1
REPLICATION_FACTOR=1

TOPICS=(
data-lin-categories-raw-one-dev
 data-lin-categorymodels-raw-one-dev
 data-lin-categoryusers-raw-one-dev
 data-lin-chips-raw-one-dev
 data-lin-clientconveyors-raw-one-dev
 data-lin-clients-raw-one-dev
 data-lin-employees-raw-one-dev
 data-lin-functions-raw-one-dev
 data-lin-garmentreturns-raw-one-dev
 data-lin-models-raw-one-dev
 data-lin-modelstorages-raw-one-dev
 data-lin-sizes-raw-one-dev
 data-lin-usermodels-raw-one-dev
)

for TOPIC in "${TOPICS[@]}"; do
  docker exec "$KAFKA_CONTAINER" kafka-topics \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    --create \
    --if-not-exists \
    --topic "$TOPIC" \
    --partitions "$PARTITIONS" \
    --replication-factor "$REPLICATION_FACTOR"
done

echo "All topics processed."
