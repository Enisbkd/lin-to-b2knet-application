#!/bin/bash
# Auto-generated curl requests
# Execute this file to send all requests

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

REQUEST_COUNT=0
SUCCESS_COUNT=0
FAILED_COUNT=0

# ========== PARAMETERS ==========
HOST="http://localhost:6060"
API_KEY="your-api-key-here"
CONVEYOR="02"
# ================================


# Function to send curl and log result
send_curl() {
  local request_num=$1
  local endpoint=$2
  local method=$3
  local payload=$4

  REQUEST_COUNT=$((REQUEST_COUNT + 1))

  echo -e "${YELLOW}--- Request #${request_num} [${endpoint}] ---${NC}"

  response=$(curl --noproxy '*' -s -w '
%{http_code}' \
    -H 'Content-Type: application/json' \
    -H "X-API-Key: ${API_KEY}" \
    -X POST "${HOST}/api/v1/import/${CONVEYOR}/${endpoint}" \
    -d "${payload}")

  http_code=$(echo "$response" | tail -1)
  body=$(echo "$response" | sed '$d')

  if [[ "$http_code" =~ ^[2][0-9]{2}$ ]]; then
    echo -e "${GREEN}HTTP $http_code${NC}"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
  else
    echo -e "${RED}HTTP $http_code${NC}"
    FAILED_COUNT=$((FAILED_COUNT + 1))
  fi

  echo "$body" | python3 -m json.tool 2>/dev/null || echo "$body"
  echo ""

  # Sleep between requests
  sleep 0.$(( RANDOM % 4 + 1 ))
}


# Request #1 - models
PAYLOAD_1='{
  \"id\": \"\"\"100\"\",
  \"modelCode\": \"MDL-lWRVqs\",
  \"modelShortDescription\": \"Short KnCVPA8M\",
  \"modelLongDescription\": \"Long description LZilgL9yPMIl\",
  \"occupation\": \"\"2\"\"\",
  \"fromDate\": \"12122024\",
  \"toDate\": \"02012025\",
  \"hungType\": \"\"\"0\"\",
  \"modelType\": \"\"2\"\"\"
}'
send_curl 1 "models" "POST" "$PAYLOAD_1"


# Request #2 - user-categories
PAYLOAD_2='{
  \"id\": \"\"\"200\"\",
  \"categoryCode\": \"CAT-p44C\",
  \"categoryDescription\": \"Category Q2RTbsoGzV\",
  \"itemCode\": \"ITEM-gCSS\",
  \"dailyCredit\": \"37\",
  \"weeklyCredit\": \"20\",
  \"dotationType\": \"0\"
}'
send_curl 2 "user-categories" "POST" "$PAYLOAD_2"


# Request #3 - sizes
PAYLOAD_3='{
  \"id\": \"\"301\"\"\",
  \"modelCode\": \"MDL-kMBt6N\",
  \"sizeCode\": \"SZ-HD1\",
  \"sizeDescription\": \"Size HPIi3a\",
  \"sizeSet\": \"SET-kD\",
  \"orderPosition\": \"22443\"
}'
send_curl 3 "sizes" "POST" "$PAYLOAD_3"


# Request #4 - users
PAYLOAD_4='{
  \"id\": \"\"401\"\"\",
  \"userNumber\": \"USR-rbGTl\",
  \"card\": \"CARDq829gA\",
  \"surname\": \"Surname8j7z\",
  \"name\": \"NameSNIc\",
  \"clientNumber\": \"CLT1Gao\",
  \"functionCode\": \"FCNG\",
  \"costCenter\": \"CC0LO\",
  \"startDate\": \"20032024\",
  \"endDate\": \"12032025\",
  \"conveyor\": \"54\",
  \"weeklyCredit\": \"12\",
  \"categoryCode\": \"CAT1r\",
  \"gender\": \"\"\"M\"\",
  \"language\": \"\"de-DE\"\",
  \"missingSize\": \"\"2\"\"\",
  \"sendMessage\": \"\"\"0\"\",
  \"phases\": \"\"1\"\"\",
  \"pickUp\": \"\"\"0\"\",
  \"primaryConveyor\": \"24\",
  \"disableDate\": \"02122027\",
  \"newUserCode\": \"NEWbpdE\",
  \"email\": \"userNF9z@test.com\",
  \"workShift\": \"\"C\"\"\"
}'
send_curl 4 "users" "POST" "$PAYLOAD_4"


# Request #5 - user-models
PAYLOAD_5='{
  \"id\": \"\"\"600\"\",
  \"userNumber\": \"USR-YTIbE\",
  \"itemCode\": \"ITEM-V0lCx\",
  \"sizeCode\": \"SZ-q92\",
  \"creditsDirtyBin\": \"29\",
  \"weeklyCredits\": \"62\",
  \"type\": \"\"1\"\",
  \"operationFlag\": \"\"\"0\"\"
}'
send_curl 5 "user-models" "POST" "$PAYLOAD_5"


# Request #6 - garments
PAYLOAD_6='{
  \"id\": \"\"501\"\"\",
  \"chipCode\": \"CHIP-tnINBxhx\",
  \"barcode\": \"BAR9A1smWMD1D\",
  \"itemCode\": \"ITEM-FF98D\",
  \"sizeCode\": \"SZ-9wy\",
  \"personalNumber\": \"PN8HNc\",
  \"client\": \"CLTg6v\",
  \"conveyor\": \"30\",
  \"storagesGroup\": \"SGsh\"
}'
send_curl 6 "garments" "POST" "$PAYLOAD_6"


# Request #7 - models
PAYLOAD_7='{
  \"id\": \"\"101\"\"\",
  \"modelCode\": \"MDL-yL7SEv\",
  \"modelShortDescription\": \"Short sgsHfzh7\",
  \"modelLongDescription\": \"Long description 6sSoytS37uzP\",
  \"occupation\": \"\"2\"\"\",
  \"fromDate\": \"25012028\",
  \"toDate\": \"26102028\",
  \"hungType\": \"\"2\"\"\",
  \"modelType\": \"\"1\"\"
}'
send_curl 7 "models" "POST" "$PAYLOAD_7"


# Request #8 - user-categories
PAYLOAD_8='{
  \"id\": \"\"\"200\"\",
  \"categoryCode\": \"CAT-hor5\",
  \"categoryDescription\": \"Category uOmoFoqObK\",
  \"itemCode\": \"ITEM-uuXZ\",
  \"dailyCredit\": \"2\",
  \"weeklyCredit\": \"6\",
  \"dotationType\": \"0\"
}'
send_curl 8 "user-categories" "POST" "$PAYLOAD_8"


# Request #9 - sizes
PAYLOAD_9='{
  \"id\": \"\"301\"\"\",
  \"modelCode\": \"MDL-SWs0P3\",
  \"sizeCode\": \"SZ-FXm\",
  \"sizeDescription\": \"Size NRa4zE\",
  \"sizeSet\": \"SET-pq\",
  \"orderPosition\": \"11334\"
}'
send_curl 9 "sizes" "POST" "$PAYLOAD_9"


# Request #10 - users
PAYLOAD_10='{
  \"id\": \"\"401\"\"\",
  \"userNumber\": \"USR-Ro00r\",
  \"card\": \"CARDffJdq7\",
  \"surname\": \"SurnameU5hJ\",
  \"name\": \"NameEvKg\",
  \"clientNumber\": \"CLTzmKk\",
  \"functionCode\": \"FCgm\",
  \"costCenter\": \"CC5W0\",
  \"startDate\": \"24062027\",
  \"endDate\": \"13092025\",
  \"conveyor\": \"63\",
  \"weeklyCredit\": \"36\",
  \"categoryCode\": \"CAT4p\",
  \"gender\": \"\"F\"\"\",
  \"language\": \"\"it-IT\"\"\",
  \"missingSize\": \"\"\"0\"\",
  \"sendMessage\": \"\"\"0\"\",
  \"phases\": \"\"\"0\"\",
  \"pickUp\": \"\"1\"\"\",
  \"primaryConveyor\": \"5\",
  \"disableDate\": \"03072026\",
  \"newUserCode\": \"NEWhLyd\",
  \"email\": \"userlUTH@test.com\",
  \"workShift\": \"\"C\"\"\"
}'
send_curl 10 "users" "POST" "$PAYLOAD_10"


# Request #11 - user-models
PAYLOAD_11='{
  \"id\": \"\"\"600\"\",
  \"userNumber\": \"USR-PUZrC\",
  \"itemCode\": \"ITEM-Vmi8x\",
  \"sizeCode\": \"SZ-I5z\",
  \"creditsDirtyBin\": \"62\",
  \"weeklyCredits\": \"41\",
  \"type\": \"\"\"0\"\",
  \"operationFlag\": \"\"1\"\"\"
}'
send_curl 11 "user-models" "POST" "$PAYLOAD_11"


# Request #12 - garments
PAYLOAD_12='{
  \"id\": \"\"501\"\"\",
  \"chipCode\": \"CHIP-YXuuIeAv\",
  \"barcode\": \"BARAjcJGqq9ms\",
  \"itemCode\": \"ITEM-20WCb\",
  \"sizeCode\": \"SZ-gnR\",
  \"personalNumber\": \"PNNIib\",
  \"client\": \"CLTni6\",
  \"conveyor\": \"2\",
  \"storagesGroup\": \"SG2d\"
}'
send_curl 12 "garments" "POST" "$PAYLOAD_12"


# Request #13 - models
PAYLOAD_13='{
  \"id\": \"\"\"100\"\",
  \"modelCode\": \"MDL-2bq71r\",
  \"modelShortDescription\": \"Short 9Jr5MGDz\",
  \"modelLongDescription\": \"Long description HGQZpCOwmXDb\",
  \"occupation\": \"\"\"1\"\",
  \"fromDate\": \"11122028\",
  \"toDate\": \"01052028\",
  \"hungType\": \"\"\"0\"\",
  \"modelType\": \"\"2\"\"\"
}'
send_curl 13 "models" "POST" "$PAYLOAD_13"


# Request #14 - user-categories
PAYLOAD_14='{
  \"id\": \"\"\"200\"\",
  \"categoryCode\": \"CAT-7fMV\",
  \"categoryDescription\": \"Category bhBktPpjcu\",
  \"itemCode\": \"ITEM-7Rwa\",
  \"dailyCredit\": \"9\",
  \"weeklyCredit\": \"57\",
  \"dotationType\": \"0\"
}'
send_curl 14 "user-categories" "POST" "$PAYLOAD_14"


# Request #15 - sizes
PAYLOAD_15='{
  \"id\": \"\"\"300\"\",
  \"modelCode\": \"MDL-Hyl4MV\",
  \"sizeCode\": \"SZ-Opm\",
  \"sizeDescription\": \"Size kyaOPb\",
  \"sizeSet\": \"SET-FL\",
  \"orderPosition\": \"30137\"
}'
send_curl 15 "sizes" "POST" "$PAYLOAD_15"


# Request #16 - users
PAYLOAD_16='{
  \"id\": \"\"401\"\"\",
  \"userNumber\": \"USR-HhbbQ\",
  \"card\": \"CARDIueq7y\",
  \"surname\": \"SurnamedYgB\",
  \"name\": \"NameqP3H\",
  \"clientNumber\": \"CLTgKWF\",
  \"functionCode\": \"FC67\",
  \"costCenter\": \"CCzqR\",
  \"startDate\": \"19032024\",
  \"endDate\": \"10092025\",
  \"conveyor\": \"41\",
  \"weeklyCredit\": \"61\",
  \"categoryCode\": \"CATHI\",
  \"gender\": \"\"F\"\"\",
  \"language\": \"\"fr-FR\"\",
  \"missingSize\": \"\"2\"\"\",
  \"sendMessage\": \"\"\"0\"\",
  \"phases\": \"\"\"0\"\",
  \"pickUp\": \"\"1\"\"\",
  \"primaryConveyor\": \"23\",
  \"disableDate\": \"11072024\",
  \"newUserCode\": \"NEWLGQc\",
  \"email\": \"user6N6o@test.com\",
  \"workShift\": \"\"C\"\"\"
}'
send_curl 16 "users" "POST" "$PAYLOAD_16"


# Request #17 - user-models
PAYLOAD_17='{
  \"id\": \"\"601\"\"\",
  \"userNumber\": \"USR-CA9hP\",
  \"itemCode\": \"ITEM-uk6n4\",
  \"sizeCode\": \"SZ-K5t\",
  \"creditsDirtyBin\": \"69\",
  \"weeklyCredits\": \"24\",
  \"type\": \"\"\"0\"\",
  \"operationFlag\": \"\"1\"\"\"
}'
send_curl 17 "user-models" "POST" "$PAYLOAD_17"


# Request #18 - garments
PAYLOAD_18='{
  \"id\": \"\"\"500\"\",
  \"chipCode\": \"CHIP-4XD2WCHu\",
  \"barcode\": \"BARtDsGDGBRJa\",
  \"itemCode\": \"ITEM-5w7gs\",
  \"sizeCode\": \"SZ-yCD\",
  \"personalNumber\": \"PNs4bh\",
  \"client\": \"CLTlth\",
  \"conveyor\": \"31\",
  \"storagesGroup\": \"SG6k\"
}'
send_curl 18 "garments" "POST" "$PAYLOAD_18"


# Request #19 - models
PAYLOAD_19='{
  \"id\": \"\"101\"\"\",
  \"modelCode\": \"MDL-nF7Jjc\",
  \"modelShortDescription\": \"Short wkDbWgZQ\",
  \"modelLongDescription\": \"Long description YBf7QoSRUopk\",
  \"occupation\": \"\"2\"\"\",
  \"fromDate\": \"02022027\",
  \"toDate\": \"11022027\",
  \"hungType\": \"\"\"0\"\",
  \"modelType\": \"\"2\"\"\"
}'
send_curl 19 "models" "POST" "$PAYLOAD_19"


# Request #20 - user-categories
PAYLOAD_20='{
  \"id\": \"\"201\"\"\",
  \"categoryCode\": \"CAT-QhOp\",
  \"categoryDescription\": \"Category 5jyp6LhKls\",
  \"itemCode\": \"ITEM-WVO1\",
  \"dailyCredit\": \"13\",
  \"weeklyCredit\": \"94\",
  \"dotationType\": \"0\"
}'
send_curl 20 "user-categories" "POST" "$PAYLOAD_20"


# ========== SUMMARY ==========
echo ""
echo "=========================================="
echo " Requests completed!"
echo " Total: $REQUEST_COUNT"
echo -e " Success: ${GREEN}$SUCCESS_COUNT${NC}"
echo -e " Failed: ${RED}$FAILED_COUNT${NC}"
echo "=========================================="

