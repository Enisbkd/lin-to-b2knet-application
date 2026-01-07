
#!/bin/bash
set -e

BASE_URL="http://localhost:6060/api/v1/import/user-conveyors" # Replace with your actual base URL or IP address

echo "Sending 20 valid user-conveyor transactions to $BASE_URL..."
echo "----------------------------------------------------------"

# Arrays for generating random valid data
USER_NUMBERS=("U12345" "U67890" "U54321" "U98765" "U11111" "U23456" "U76543" "U87654" "U34567" "U56789")
VALID_IDS=("410" "411") # Only valid IDs based on the requirement
VALID_CONVEYOR_CODES=("01" "02" "03" "04" "05" "06" "07" "08" "09" "10") # 2-digit codes
VALID_GATE_CODES=("01" "02" "05" "10" "15" "20" "25" "") # Up to 2 digits or empty
VALID_BINARY=("0" "1") # For primary and assignSlot

# Send 20 POST requests
for i in $(seq 1 20); do
    TRANSACTION_ID=${VALID_IDS[RANDOM % ${#VALID_IDS[@]}]} # Pick a random valid ID
    USER_NUMBER=${USER_NUMBERS[RANDOM % ${#USER_NUMBERS[@]}]}          # Pick a random user number

    # Create JSON payload based on transaction ID
    if [ "$TRANSACTION_ID" = "410" ]; then
        # Transaction 410: Include all fields
        CONVEYOR_CODE=${VALID_CONVEYOR_CODES[RANDOM % ${#VALID_CONVEYOR_CODES[@]}]}
        GATE_CODE=${VALID_GATE_CODES[RANDOM % ${#VALID_GATE_CODES[@]}]}
        PRIMARY=${VALID_BINARY[RANDOM % ${#VALID_BINARY[@]}]}
        ASSIGN_SLOT=${VALID_BINARY[RANDOM % ${#VALID_BINARY[@]}]}

        JSON_PAYLOAD=$(cat <<EOF
{
    "id": "$TRANSACTION_ID",
    "userNumber": "$USER_NUMBER",
    "conveyorCode": "$CONVEYOR_CODE",
    "gateCode": "$GATE_CODE",
    "primary": "$PRIMARY",
    "assignSlot": "$ASSIGN_SLOT"
}
EOF
)
    else
        # Transaction 411: Only id and userNumber
        JSON_PAYLOAD=$(cat <<EOF
{
    "id": "$TRANSACTION_ID",
    "userNumber": "$USER_NUMBER"
}
EOF
)
    fi

    # Send HTTP POST request
    echo "Sending request #$i with payload:"
    echo "$JSON_PAYLOAD"
    curl --noproxy '*' -X POST "$BASE_URL" \
        -H "Content-Type: application/json" \
        -d "$JSON_PAYLOAD"
    echo -e "\nResponse for transaction $TRANSACTION_ID sent successfully!"

    # Optional delay (to reduce server load)
    sleep 0
done

echo "----------------------------------------------------------"
echo "All 20 user-conveyor transactions successfully sent!"
