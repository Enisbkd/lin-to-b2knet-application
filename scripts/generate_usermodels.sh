#!/bin/bash

# Configuration
BASE_URL="http://localhost:6060"
ENDPOINT="/api/v1/import/one/user-models"
USER_MODEL_IDS=("600" "601")

# Arrays for random data generation
SIZE_CODES=("XS" "S" "M" "L" "XL" "XXL")
TYPES=("0" "1" "2")
OPERATION_FLAGS=("0" "1")

echo "Starting to generate 100 user-model POST requests..."
echo "Target: ${BASE_URL}${ENDPOINT}"
echo "=========================================="

for i in $(seq 1 100); do
    # Alternate between user-model IDs 600 and 601
    USER_MODEL_ID=${USER_MODEL_IDS[$((i % 2))]}

    # Generate random data
    USER_NUMBER="USR-$(printf "%08d" $((RANDOM % 1000 + 1)))"
    ITEM_CODE="ITEM-${i}-$(printf "%06d" $RANDOM)"
    SIZE_CODE=${SIZE_CODES[$((RANDOM % ${#SIZE_CODES[@]}))]}
    CREDITS_DIRTY=$((RANDOM % 99 + 1))
    WEEKLY_CREDITS=$((RANDOM % 99 + 1))
    TYPE=${TYPES[$((RANDOM % ${#TYPES[@]}))]}
    OPERATION_FLAG=${OPERATION_FLAGS[$((RANDOM % ${#OPERATION_FLAGS[@]}))]}

    # Create JSON payload
    JSON_PAYLOAD=$(cat <<EOF
{
  "id": "${USER_MODEL_ID}",
  "userNumber": "${USER_NUMBER}",
  "itemCode": "${ITEM_CODE}",
  "sizeCode": "${SIZE_CODE}",
  "creditsDirtyBin": "${CREDITS_DIRTY}",
  "weeklyCredits": "${WEEKLY_CREDITS}",
  "type": "${TYPE}",
  "operationFlag": "${OPERATION_FLAG}"
}
EOF
)

    # Send POST request
    echo "[$i/100] ID: ${USER_MODEL_ID}, User: ${USER_NUMBER}, Item: ${ITEM_CODE}, Size: ${SIZE_CODE}"

    RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
        --noproxy '*' \
        -H "Content-Type: application/json" \
        -d "${JSON_PAYLOAD}" \
        "${BASE_URL}${ENDPOINT}")

    HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
    BODY=$(echo "$RESPONSE" | sed '$d')

    if [ "$HTTP_CODE" -eq 202 ]; then
        echo "  ✓ Success (HTTP $HTTP_CODE)"
    else
        echo "  ✗ Failed (HTTP $HTTP_CODE)"
        echo "  Response: $BODY"
    fi

    # Small delay to avoid overwhelming the server
    sleep 0.1
done

echo "=========================================="
echo "Completed: 100 user-model POST requests sent"
