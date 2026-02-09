#!/bin/bash

# Configuration
BASE_URL="http://localhost:6060"
ENDPOINT="/api/v1/import/one/sizes"
SIZE_IDS=("300" "301")

# Arrays for random data generation
SIZE_CODES=("XS" "S" "M" "L" "XL" "XXL" "2XL" "3XL")
SIZE_DESCRIPTIONS=("Extra Small" "Small" "Medium" "Large" "Extra Large" "Double XL" "Triple XL")
SIZE_SETS=("SET-A" "SET-B" "SET-C" "SET-D" "SET-E")

echo "Starting to generate 100 size POST requests..."
echo "Target: ${BASE_URL}${ENDPOINT}"
echo "=========================================="

for i in $(seq 1 100); do
    # Alternate between size IDs 300 and 301
    SIZE_ID=${SIZE_IDS[$((i % 2))]}

    # Generate random data
    MODEL_CODE="MODEL-${i}-$(printf "%04d" $RANDOM)"
    SIZE_CODE=${SIZE_CODES[$((RANDOM % ${#SIZE_CODES[@]}))]}
    SIZE_DESC=${SIZE_DESCRIPTIONS[$((RANDOM % ${#SIZE_DESCRIPTIONS[@]}))]}
    SIZE_SET=${SIZE_SETS[$((RANDOM % ${#SIZE_SETS[@]}))]}
    ORDER_POS=$((RANDOM % 100 + 1))

    # Create JSON payload
    JSON_PAYLOAD=$(cat <<EOF
{
  "id": "${SIZE_ID}",
  "modelCode": "${MODEL_CODE}",
  "sizeCode": "${SIZE_CODE}",
  "sizeDescription": "${SIZE_DESC}",
  "sizeSet": "${SIZE_SET}",
  "orderPosition": "${ORDER_POS}"
}
EOF
)

    # Send POST request
    echo "[$i/100] ID: ${SIZE_ID}, Model: ${MODEL_CODE}, Size: ${SIZE_CODE}, Order: ${ORDER_POS}"

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
    sleep 0
done

echo "=========================================="
echo "Completed: 100 size POST requests sent"
