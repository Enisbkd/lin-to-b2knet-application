#!/bin/bash
# =============================================================
# Generate simple curl commands to file with variables
# Usage: ./generate_curls.sh [count] [conveyor] [host] [api-key]
#   count    - number of requests to generate (default: 20)
#   conveyor - conveyor code (default: 02)
#   host     - API host (default: http://localhost:6060)
#   api-key  - API key (default: your-api-key-here)
# =============================================================

set -euo pipefail

# Parameters
COUNT=${1:-20}
CONVEYOR=${2:-02}
HOST=${3:-http://localhost:6060}
API_KEY=${4:-your-api-key-here}

# Output file
OUTPUT_FILE="curl_requests_${CONVEYOR}_$(date +%s).sh"

BASE_URL="$HOST/api/v1/import"

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

# ---------- Initialize output file ----------
cat > "$OUTPUT_FILE" <<'FILEHEADER'
#!/bin/bash
# Auto-generated curl requests
# Simple curl commands with variables

set -euo pipefail

FILEHEADER

# Add parameters section
cat >> "$OUTPUT_FILE" <<PARAMS
# ========== CONFIGURATION ==========
HOST="$HOST"
API_KEY="$API_KEY"
CONVEYOR="$CONVEYOR"
BASE_URL="\$HOST/api/v1/import/\$CONVEYOR"
# ==================================

PARAMS

# ---------- main loop - generate curl commands ----------
echo "Generating $COUNT simple curl requests to $OUTPUT_FILE..."

for i in $(seq 1 "$COUNT"); do
  idx=$(( (i - 1) % NUM_ENDPOINTS ))
  entry="${ORDERED_ENDPOINTS[$idx]}"
  path="${entry%%|*}"
  generator="${entry##*|}"

  payload="$($generator)"

  # Escape payload for shell
  escaped_payload=$(echo "$payload" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')

  # Write curl command with payload in same block
  cat >> "$OUTPUT_FILE" <<CURLCMD

# Request #$i - $path
curl --noproxy '*' -s -X POST "\$BASE_URL/$path" \\
  -H "Content-Type: application/json" \\
  -H "X-API-Key: \$API_KEY" \\
  -d '$payload'

CURLCMD
done

# Make the output file executable
chmod +x "$OUTPUT_FILE"

echo "==========================================="
echo " Simple curl requests file generated!"
echo " File: $OUTPUT_FILE"
echo " Host: $HOST"
echo " Conveyor: $CONVEYOR"
echo " API Key: ${API_KEY:0:10}..."
echo " Total requests: $COUNT"
echo ""
echo " To execute all requests, run:"
echo " ./$OUTPUT_FILE"
echo "==========================================="
