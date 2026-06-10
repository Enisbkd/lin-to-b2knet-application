#!/bin/bash
# =============================================================
# Ordered POST requests to all import endpoints
# Sequence: 100 -> 200 -> 300 -> 400 -> 600 -> 500
# Usage: ./random_requests.sh [count] [conveyor]
#   count    - number of requests to send (default: 20)
#   conveyor - conveyor code (default: one)
# =============================================================

set -euo pipefail

BASE_URL="http://localhost:6060/api/v1/import"

COUNT=${1:-100}
CONVEYOR=${2:-hh}

# ---------- helpers ----------
rand_str()  { cat /dev/urandom | tr -dc 'A-Za-z0-9' | head -c "$1"; }
rand_num()  { echo $((RANDOM % $1)); }
rand_date() { printf '%02d%02d%04d' $((RANDOM % 28 + 1)) $((RANDOM % 12 + 1)) $((RANDOM % 5 + 2024)); }
pick()      { local arr=("$@"); echo "${arr[$((RANDOM % ${#arr[@]}))]}"; }

# ---------- payload generators ----------
models_payload() {
  local id=$(pick 100 101)
  cat <<EOF
{
  "id": "$id",
  "modelCode": "MDL-$(rand_str 6)",
  "modelShortDescription": "Short $(rand_str 8)",
  "modelLongDescription": "Long description $(rand_str 12)",
  "occupation": "$(pick 1 2)",
  "fromDate": "$(rand_date)",
  "toDate": "$(rand_date)",
  "hungType": "$(pick 0 1 2)",
  "modelType": "$(pick 0 1 2)"
}
EOF
}

categories_payload() {
  local id=$(pick 200 201)
  cat <<EOF
{
  "id": "$id",
  "categoryCode": "CAT-$(rand_str 4)",
  "categoryDescription": "Category $(rand_str 10)",
  "itemCode": "ITEM-$(rand_str 4)",
  "dailyCredit": "$(rand_num 99)",
  "weeklyCredit": "$(rand_num 99)",
  "dotationType": "0"
}
EOF
}

sizes_payload() {
  local id=$(pick 300 301)
  cat <<EOF
{
  "id": "$id",
  "modelCode": "MDL-$(rand_str 6)",
  "sizeCode": "SZ-$(rand_str 3)",
  "sizeDescription": "Size $(rand_str 6)",
  "sizeSet": "SET-$(rand_str 2)",
  "orderPosition": "$(rand_num 99999)"
}
EOF
}

users_payload() {
  local id=$(pick 400 401)
  cat <<EOF
{
  "id": "$id",
  "userNumber": "USR-$(rand_str 5)",
  "card": "CARD$(rand_str 6)",
  "surname": "Surname$(rand_str 4)",
  "name": "Name$(rand_str 4)",
  "clientNumber": "CLT$(rand_str 4)",
  "functionCode": "FC$(rand_str 2)",
  "costCenter": "CC$(rand_str 3)",
  "startDate": "$(rand_date)",
  "endDate": "$(rand_date)",
  "conveyor": "$(rand_num 99)",
  "weeklyCredit": "$(rand_num 99)",
  "categoryCode": "CAT$(rand_str 2)",
  "gender": "$(pick M F)",
  "language": "$(pick en-US fr-FR de-DE it-IT)",
  "missingSize": "$(pick 0 1 2)",
  "sendMessage": "$(pick 0 1 2)",
  "phases": "$(pick 0 1)",
  "pickUp": "$(pick 0 1)",
  "primaryConveyor": "$(rand_num 99)",
  "disableDate": "$(rand_date)",
  "newUserCode": "NEW$(rand_str 4)",
  "email": "user$(rand_str 4)@test.com",
  "workShift": "$(pick A B C)"
}
EOF
}

garments_payload() {
  local id=$(pick 500 501)
  cat <<EOF
{
  "id": "$id",
  "chipCode": "CHIP-$(rand_str 8)",
  "barcode": "BAR$(rand_str 10)",
  "itemCode": "ITEM-$(rand_str 5)",
  "sizeCode": "SZ-$(rand_str 3)",
  "personalNumber": "PN$(rand_str 4)",
  "client": "CLT$(rand_str 3)",
  "conveyor": "$(rand_num 99)",
  "storagesGroup": "SG$(rand_str 2)"
}
EOF
}

user_models_payload() {
  local id=$(pick 600 601)
  cat <<EOF
{
  "id": "$id",
  "userNumber": "USR-$(rand_str 5)",
  "itemCode": "ITEM-$(rand_str 5)",
  "sizeCode": "SZ-$(rand_str 3)",
  "creditsDirtyBin": "$(rand_num 99)",
  "weeklyCredits": "$(rand_num 99)",
  "type": "$(pick 0 1 2)",
  "operationFlag": "$(pick 0 1)"
}
EOF
}

# ---------- endpoint definitions ----------
ORDERED_ENDPOINTS=(
  "models|models_payload"
  "user-categories|categories_payload"
  "sizes|sizes_payload"
  "users|users_payload"
  "user-models|user_models_payload"
  "garments|garments_payload"
)

NUM_ENDPOINTS=${#ORDERED_ENDPOINTS[@]}

# ---------- main loop ----------
echo "=========================================="
echo " Sending $COUNT requests in order"
echo " Order: 100 -> 200 -> 300 -> 400 -> 600 -> 500"
echo " Target: $BASE_URL/$CONVEYOR/*"
echo "=========================================="

for i in $(seq 1 "$COUNT"); do
  idx=$(( (i - 1) % NUM_ENDPOINTS ))
  entry="${ORDERED_ENDPOINTS[$idx]}"
  path="${entry%%|*}"
  generator="${entry##*|}"

  payload="$($generator)"
  url="$BASE_URL/$CONVEYOR/$path"

  echo ""
  echo "--- Request #$i  [$path] ---"
  echo "POST $url"
  echo "$payload" | python3 -m json.tool 2>/dev/null || echo "$payload"

  response=$(curl --noproxy '*' -s -w '\n%{http_code}' \
    -H 'Content-Type: application/json' \
    -X POST "$url" \
    -d "$payload")

  http_code=$(echo "$response" | tail -1)
  body=$(echo "$response" | sed '$d')

  echo "HTTP $http_code"
  echo "$body" | python3 -m json.tool 2>/dev/null || echo "$body"

  # Sleep between 0.1 and 0.5 seconds
  sleep "0.$(( RANDOM % 4 + 1 ))"
done

echo ""
echo "=========================================="
echo " Done! Sent $COUNT requests."
echo "=========================================="
