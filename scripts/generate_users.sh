#!/bin/bash

# Configuration
BASE_URL="http://localhost:6060"
ENDPOINT="/api/v1/import/one/users"
USER_IDS=("400" "401")

# Arrays for random data generation
SURNAMES=("Smith" "Johnson" "Williams" "Brown" "Jones" "Garcia" "Miller" "Davis" "Rodriguez" "Martinez")
NAMES=("John" "Mary" "James" "Patricia" "Robert" "Jennifer" "Michael" "Linda" "William" "Elizabeth")
GENDERS=("M" "F")
LANGUAGES=("en-US" "es-ES" "fr-FR" "de-DE" "it-IT" "pt-PT")
FUNCTIONS=("FN-001" "FN-002" "FN-003" "FN-004" "FN-005")
CATEGORIES=("CAT-A" "CAT-B" "CAT-C" "CAT-D")
WORK_SHIFTS=("MORNING" "AFTERNOON" "NIGHT")

echo "Starting to generate 100 user POST requests..."
echo "Target: ${BASE_URL}${ENDPOINT}"
echo "=========================================="

for i in $(seq 1 100); do
    # Alternate between user IDs 400 and 401
    USER_ID=${USER_IDS[$((i % 2))]}

    # Generate random data
    USER_NUMBER="USR-$(printf "%08d" $i)"
    CARD="CARD-$(printf "%012d" $((RANDOM * RANDOM)))"
    SURNAME=${SURNAMES[$((RANDOM % ${#SURNAMES[@]}))]}
    NAME=${NAMES[$((RANDOM % ${#NAMES[@]}))]}
    CLIENT_NUM="CLI-$(printf "%06d" $RANDOM)"
    FUNCTION_CODE=${FUNCTIONS[$((RANDOM % ${#FUNCTIONS[@]}))]}
    COST_CENTER="CC-$(printf "%04d" $RANDOM)"
    START_DATE=$(date -d "$(($RANDOM % 365)) days ago" +%d%m%Y)
    END_DATE=$(date -d "+$(($RANDOM % 365)) days" +%d%m%Y)
    CONVEYOR=$((RANDOM % 99 + 1))
    WEEKLY_CREDIT=$((RANDOM % 99 + 1))
    CATEGORY=${CATEGORIES[$((RANDOM % ${#CATEGORIES[@]}))]}
    GENDER=${GENDERS[$((RANDOM % ${#GENDERS[@]}))]}
    LANGUAGE=${LANGUAGES[$((RANDOM % ${#LANGUAGES[@]}))]}
    MISSING_SIZE=$((RANDOM % 3))
    SEND_MESSAGE=$((RANDOM % 3))
    PHASES=$((RANDOM % 2))
    PICKUP=$((RANDOM % 2))
    PRIMARY_CONV=$((RANDOM % 99 + 1))
    DISABLE_DATE=$(date -d "+$(($RANDOM % 1000)) days" +%d%m%Y)
    NEW_USER_CODE="NEWUSR-$(printf "%06d" $RANDOM)"
    EMAIL="user${i}@example.com"
    WORK_SHIFT=${WORK_SHIFTS[$((RANDOM % ${#WORK_SHIFTS[@]}))]}

    # Create JSON payload
    JSON_PAYLOAD=$(cat <<EOF
{
  "id": "${USER_ID}",
  "userNumber": "${USER_NUMBER}",
  "card": "${CARD}",
  "surname": "${SURNAME}",
  "name": "${NAME}",
  "clientNumber": "${CLIENT_NUM}",
  "functionCode": "${FUNCTION_CODE}",
  "costCenter": "${COST_CENTER}",
  "startDate": "${START_DATE}",
  "endDate": "${END_DATE}",
  "conveyor": "${CONVEYOR}",
  "weeklyCredit": "${WEEKLY_CREDIT}",
  "categoryCode": "${CATEGORY}",
  "gender": "${GENDER}",
  "language": "${LANGUAGE}",
  "missingSize": "${MISSING_SIZE}",
  "sendMessage": "${SEND_MESSAGE}",
  "phases": "${PHASES}",
  "pickUp": "${PICKUP}",
  "primaryConveyor": "${PRIMARY_CONV}",
  "disableDate": "${DISABLE_DATE}",
  "newUserCode": "${NEW_USER_CODE}",
  "email": "${EMAIL}",
  "workShift": "${WORK_SHIFT}"
}
EOF
)

    # Send POST request
    echo "[$i/100] ID: ${USER_ID}, User: ${USER_NUMBER}, Name: ${NAME} ${SURNAME}"

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
echo "Completed: 100 user POST requests sent"
