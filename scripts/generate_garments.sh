#!/bin/bash

# Configuration
BASE_URL="http://localhost:6060"
ENDPOINT="/api/v1/import/one/garments"
GARMENT_IDS=("500" "501")

# Arrays for random data generation
SIZES=("XS" "S" "M" "L" "XL" "XXL")
CLIENTS=("CLIENT-A" "CLIENT-B" "CLIENT-C" "CLIENT-D" "CLIENT-E")
CONVEYORS=("1" "2" "5" "10" "15" "20" "99")
STORAGE_GROUPS=("STG-A" "STG-B" "STG-C" "STG-D" "STG-E")

echo "Starting to generate 100 garment POST requests..."
echo "Target: ${BASE_URL}${ENDPOINT}"
echo "=========================================="

for i in $(seq 1 100); do
    # Alternate between garment IDs 500 and 501
    GARMENT_ID=${GARMENT_IDS[$((i % 2))]}

    # Generate random data
    CHIP_CODE="CHIP$(printf "%020d" $((RANDOM * RANDOM)))"
    BARCODE="BAR$(printf "%021d" $((RANDOM * RANDOM)))"
    ITEM_CODE="ITEM-${i}-$(printf "%06d" $RANDOM)"
    SIZE_CODE=${SIZES[$((RANDOM % ${#SIZES[@]}))]}
    PERSONAL_NUM="P$(printf "%011d" $((RANDOM * RANDOM % 100000000000)))"
    CLIENT=${CLIENTS[$((RANDOM % ${#CLIENTS[@]}))]}
    CONVEYOR=${CONVEYORS[$((RANDOM % ${#CONVEYORS[@]}))]}
    STORAGE_GRP=${STORAGE_GROUPS[$((RANDOM % ${#STORAGE_GROUPS[@]}))]}

    # Create JSON payload
    JSON_PAYLOAD=$(cat <<EOF
{
  "id": "${GARMENT_ID}",
  "chipCode": "${CHIP_CODE}",
  "barcode": "${BARCODE}",
  "itemCode": "${ITEM_CODE}",
  "sizeCode": "${SIZE_CODE}",
  "personalNumber": "${PERSONAL_NUM}",
  "client": "${CLIENT}",
  "conveyor": "${CONVEYOR}",
  "storagesGroup": "${STORAGE_GRP}"
}
EOF
)

    # Send POST request
    echo "[$i/100] ID: ${GARMENT_ID}, Item: ${ITEM_CODE}, Size: ${SIZE_CODE}, Client: ${CLIENT}"

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
echo "Completed: 100 garment POST requests sent"
