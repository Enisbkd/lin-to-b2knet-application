#!/bin/bash

# Kafka Topic Creation Script
# This script creates all required topics for the LinToB2knet application

set -e  # Exit on error

# Configuration
KAFKA_CONTAINER="broker"
BOOTSTRAP_SERVER="localhost:9092"
PARTITIONS=3
REPLICATION_FACTOR=1
ENV="dev"  # Change this to your environment: dev, test, prod

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}  Kafka Topic Creation Script${NC}"
echo -e "${BLUE}  Environment: ${ENV}${NC}"
echo -e "${BLUE}================================================${NC}\n"

# Function to create a topic
create_topic() {
    local topic_name=$1
    local partitions=${2:-$PARTITIONS}
    local replication=${3:-$REPLICATION_FACTOR}

    echo -e "${YELLOW}Creating topic: ${topic_name}${NC}"

    if docker exec $KAFKA_CONTAINER kafka-topics \
        --bootstrap-server $BOOTSTRAP_SERVER \
        --create \
        --topic "$topic_name" \
        --partitions $partitions \
        --replication-factor $replication \
        --if-not-exists 2>/dev/null; then
        echo -e "${GREEN}✓ Topic created successfully: ${topic_name}${NC}\n"
    else
        echo -e "${RED}✗ Failed to create topic: ${topic_name}${NC}\n"
        return 1
    fi
}

# Function to list topics
list_topics() {
    echo -e "${BLUE}Listing all topics:${NC}"
    docker exec $KAFKA_CONTAINER kafka-topics \
        --bootstrap-server $BOOTSTRAP_SERVER \
        --list | grep "data-lin" || echo "No data-lin topics found"
    echo ""
}

# Function to describe a topic
describe_topic() {
    local topic_name=$1
    echo -e "${BLUE}Describing topic: ${topic_name}${NC}"
    docker exec $KAFKA_CONTAINER kafka-topics \
        --bootstrap-server $BOOTSTRAP_SERVER \
        --describe \
        --topic "$topic_name"
    echo ""
}

# Arrays for entities and conveyors
ENTITIES=("models" "sizes" "users" "usermodels" "garments")
CONVEYORS=("hp" "one")

echo -e "${BLUE}Step 1: Creating RAW topics (10 topics total)${NC}\n"

# Create RAW topics (5 entities × 2 conveyors = 10 topics)
for conveyor in "${CONVEYORS[@]}"; do
    for entity in "${ENTITIES[@]}"; do
        topic_name="data-lin-${entity}-raw-${conveyor}-${ENV}"
        create_topic "$topic_name" $PARTITIONS $REPLICATION_FACTOR
    done
done

echo -e "${BLUE}Step 2: Creating FORMATTED topics (2 topics total)${NC}\n"

# Create FORMATTED topics (1 per conveyor = 2 topics)
for conveyor in "${CONVEYORS[@]}"; do
    topic_name="data-lin-${conveyor}-${ENV}"
    create_topic "$topic_name" $PARTITIONS $REPLICATION_FACTOR
done

echo -e "${GREEN}================================================${NC}"
echo -e "${GREEN}  Topic Creation Complete!${NC}"
echo -e "${GREEN}================================================${NC}\n"

# Summary
echo -e "${BLUE}Summary:${NC}"
echo -e "  - RAW topics created: 10 (5 entities × 2 conveyors)"
echo -e "  - FORMATTED topics created: 2 (1 per conveyor)"
echo -e "  - Total topics created: 12"
echo -e "  - Partitions per topic: $PARTITIONS"
echo -e "  - Replication factor: $REPLICATION_FACTOR"
echo -e "  - Environment: $ENV\n"

# List all created topics
list_topics

# Optional: Describe one topic as example
echo -e "${YELLOW}Would you like to see detailed info for a topic? (y/n)${NC}"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Enter topic name (or press Enter for data-lin-models-raw-hp-${ENV}):${NC}"
    read -r topic_input
    topic_to_describe=${topic_input:-"data-lin-models-raw-hp-${ENV}"}
    describe_topic "$topic_to_describe"
fi

echo -e "${GREEN}Done!${NC}"
