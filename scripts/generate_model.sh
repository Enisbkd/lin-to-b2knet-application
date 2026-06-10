#!/bin/bash

# Adjust the host and port if necessary
URL="http://localhost:6060/api/v1/import/one/models"

echo "Starting to send 10 requests to $URL..."

for i in {1..100}
do
    # Generate random data conforming to ModelTransaction structure
    # ID: 100 or 101
    ID=$(( ( RANDOM % 2 ) + 100 ))

    # Model Code: 12 alphanumeric characters
    MODEL_CODE=$(cat /dev/urandom | tr -dc 'A-Z0-9' | fold -w 12 | head -n 1)

    # Descriptions
    SHORT_DESC="Desc $MODEL_CODE"
    LONG_DESC="Long Description for model $MODEL_CODE generated at $(date +%T)"

        # Occupation: 1 or 2
        OCCUPATION=$(( ( RANDOM % 2 ) + 1 ))

    # Dates: DDMMYYYY format
    # Generating a random day/month/year for FromDate
    DAY=$(printf "%02d" $(( ( RANDOM % 28 ) + 1 )))
    MONTH=$(printf "%02d" $(( ( RANDOM % 12 ) + 1 )))
    YEAR=$(( ( RANDOM % 3 ) + 2023 ))
    FROM_DATE="${DAY}${MONTH}${YEAR}"
    # ToDate is just +1 year roughly
    TO_DATE="${DAY}${MONTH}$(( YEAR + 1 ))"

        # Types: 0, 1, or 2
        HUNG_TYPE=$(( RANDOM % 3 ))
        MODEL_TYPE=$(( RANDOM % 3 ))

    # Construct JSON
    JSON_PAYLOAD=$(cat <<EOF
{
  "id": "$ID",
  "modelCode": "$MODEL_CODE",
  "modelShortDescription": "Desc $SHORT_DESC",
  "modelLongDescription": "$LONG_DESC",
  "occupation": "$OCCUPATION",
  "fromDate": "$FROM_DATE",
  "toDate": "$TO_DATE",
  "hungType": "$HUNG_TYPE",
  "modelType": "$MODEL_TYPE"
}
EOF
)

    echo "Sending Request #$i with ModelCode: $MODEL_CODE"

    # Send POST request
    curl --noproxy '*' -s -X POST "$URL" \
         -H "Content-Type: application/json" \
         -d "$JSON_PAYLOAD"

    echo "" # New line for readability

    sleep 0
done

echo "Done."
