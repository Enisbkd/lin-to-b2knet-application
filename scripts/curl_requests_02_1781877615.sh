#!/bin/bash
# Auto-generated curl requests
# Simple curl commands with variables

set -euo pipefail

# ========== CONFIGURATION ==========
HOST="https://apm-gw-stage0.sbm.prod/conveyor/v1/api/v1/movements"
API_KEY="4bcc2bac-de1d-413f-8c2b-acde1df13f5a"
CONVEYOR="02"
BASE_URL="$HOST/api/v1/import/$CONVEYOR"
# ==================================


# Request #1 - models
PAYLOAD_1='{
  \"id\": \"100\",
  \"modelCode\": \"MDL-2OGAyO\",
  \"modelShortDescription\": \"Short AVdB7fx2\",
  \"modelLongDescription\": \"Long description zT4KpKyoyo7m\",
  \"occupation\": \"2\",
  \"fromDate\": \"01032028\",
  \"toDate\": \"06032025\",
  \"hungType\": \"0\",
  \"modelType\": \"1\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_1"


# Request #2 - user-categories
PAYLOAD_2='{
  \"id\": \"200\",
  \"categoryCode\": \"CAT-ztyE\",
  \"categoryDescription\": \"Category roZNTToUFu\",
  \"itemCode\": \"ITEM-Knsu\",
  \"dailyCredit\": \"91\",
  \"weeklyCredit\": \"58\",
  \"dotationType\": \"0\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/user-categories" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_2"


# Request #3 - sizes
PAYLOAD_3='{
  \"id\": \"300\",
  \"modelCode\": \"MDL-PCWLXl\",
  \"sizeCode\": \"SZ-pmR\",
  \"sizeDescription\": \"Size NP8ZoG\",
  \"sizeSet\": \"SET-QW\",
  \"orderPosition\": \"1008\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/sizes" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_3"


# Request #4 - users
PAYLOAD_4='{
  \"id\": \"400\",
  \"userNumber\": \"USR-i4NkI\",
  \"card\": \"CARDKkqE5c\",
  \"surname\": \"Surname4mnB\",
  \"name\": \"NamehaMu\",
  \"clientNumber\": \"CLTLzEw\",
  \"functionCode\": \"FCyY\",
  \"costCenter\": \"CCgOl\",
  \"startDate\": \"25102024\",
  \"endDate\": \"19092024\",
  \"conveyor\": \"63\",
  \"weeklyCredit\": \"94\",
  \"categoryCode\": \"CAT4D\",
  \"gender\": \"M\",
  \"language\": \"de-DE\",
  \"missingSize\": \"2\",
  \"sendMessage\": \"2\",
  \"phases\": \"0\",
  \"pickUp\": \"1\",
  \"primaryConveyor\": \"24\",
  \"disableDate\": \"23102028\",
  \"newUserCode\": \"NEWS4pv\",
  \"email\": \"userQOhm@test.com\",
  \"workShift\": \"B\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/users" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_4"


# Request #5 - user-models
PAYLOAD_5='{
  \"id\": \"601\",
  \"userNumber\": \"USR-w3ZOV\",
  \"itemCode\": \"ITEM-on0ni\",
  \"sizeCode\": \"SZ-5uG\",
  \"creditsDirtyBin\": \"12\",
  \"weeklyCredits\": \"17\",
  \"type\": \"2\",
  \"operationFlag\": \"1\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/user-models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_5"


# Request #6 - garments
PAYLOAD_6='{
  \"id\": \"500\",
  \"chipCode\": \"CHIP-x67yVXbg\",
  \"barcode\": \"BARGNhuuQl1uF\",
  \"itemCode\": \"ITEM-6akG4\",
  \"sizeCode\": \"SZ-oCI\",
  \"personalNumber\": \"PNV42j\",
  \"client\": \"CLTzxe\",
  \"conveyor\": \"12\",
  \"storagesGroup\": \"SGUn\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/garments" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_6"


# Request #7 - models
PAYLOAD_7='{
  \"id\": \"100\",
  \"modelCode\": \"MDL-1B9xtb\",
  \"modelShortDescription\": \"Short Rdr7T8BR\",
  \"modelLongDescription\": \"Long description MhsNM9P4dFfQ\",
  \"occupation\": \"1\",
  \"fromDate\": \"14072026\",
  \"toDate\": \"19042028\",
  \"hungType\": \"0\",
  \"modelType\": \"0\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_7"


# Request #8 - user-categories
PAYLOAD_8='{
  \"id\": \"201\",
  \"categoryCode\": \"CAT-zu6f\",
  \"categoryDescription\": \"Category U0P23bEuCP\",
  \"itemCode\": \"ITEM-8P7v\",
  \"dailyCredit\": \"77\",
  \"weeklyCredit\": \"0\",
  \"dotationType\": \"0\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/user-categories" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_8"


# Request #9 - sizes
PAYLOAD_9='{
  \"id\": \"301\",
  \"modelCode\": \"MDL-cmAYrc\",
  \"sizeCode\": \"SZ-8Dn\",
  \"sizeDescription\": \"Size I3lXp2\",
  \"sizeSet\": \"SET-2W\",
  \"orderPosition\": \"12198\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/sizes" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_9"


# Request #10 - users
PAYLOAD_10='{
  \"id\": \"400\",
  \"userNumber\": \"USR-XoBk8\",
  \"card\": \"CARDKcEuXD\",
  \"surname\": \"SurnameeooE\",
  \"name\": \"NamepsXD\",
  \"clientNumber\": \"CLTIKJM\",
  \"functionCode\": \"FCD2\",
  \"costCenter\": \"CC6OB\",
  \"startDate\": \"20122024\",
  \"endDate\": \"12072026\",
  \"conveyor\": \"96\",
  \"weeklyCredit\": \"18\",
  \"categoryCode\": \"CATpR\",
  \"gender\": \"F\",
  \"language\": \"en-US\",
  \"missingSize\": \"2\",
  \"sendMessage\": \"0\",
  \"phases\": \"0\",
  \"pickUp\": \"1\",
  \"primaryConveyor\": \"55\",
  \"disableDate\": \"16092024\",
  \"newUserCode\": \"NEWNwyO\",
  \"email\": \"user4vr4@test.com\",
  \"workShift\": \"A\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/users" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_10"


# Request #11 - user-models
PAYLOAD_11='{
  \"id\": \"600\",
  \"userNumber\": \"USR-51S0l\",
  \"itemCode\": \"ITEM-nmoYf\",
  \"sizeCode\": \"SZ-1vA\",
  \"creditsDirtyBin\": \"87\",
  \"weeklyCredits\": \"40\",
  \"type\": \"0\",
  \"operationFlag\": \"0\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/user-models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_11"


# Request #12 - garments
PAYLOAD_12='{
  \"id\": \"501\",
  \"chipCode\": \"CHIP-vjhrswIk\",
  \"barcode\": \"BARCg4PMwLBMG\",
  \"itemCode\": \"ITEM-Pyk5j\",
  \"sizeCode\": \"SZ-oDf\",
  \"personalNumber\": \"PNX39f\",
  \"client\": \"CLT7jF\",
  \"conveyor\": \"82\",
  \"storagesGroup\": \"SGjS\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/garments" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_12"


# Request #13 - models
PAYLOAD_13='{
  \"id\": \"100\",
  \"modelCode\": \"MDL-3kAUMt\",
  \"modelShortDescription\": \"Short X2dtRVCT\",
  \"modelLongDescription\": \"Long description 07cjsqh41In7\",
  \"occupation\": \"2\",
  \"fromDate\": \"07092026\",
  \"toDate\": \"25062024\",
  \"hungType\": \"0\",
  \"modelType\": \"0\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_13"


# Request #14 - user-categories
PAYLOAD_14='{
  \"id\": \"200\",
  \"categoryCode\": \"CAT-759n\",
  \"categoryDescription\": \"Category RTGgUMCACt\",
  \"itemCode\": \"ITEM-djZk\",
  \"dailyCredit\": \"3\",
  \"weeklyCredit\": \"58\",
  \"dotationType\": \"0\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/user-categories" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_14"


# Request #15 - sizes
PAYLOAD_15='{
  \"id\": \"301\",
  \"modelCode\": \"MDL-lUMJJP\",
  \"sizeCode\": \"SZ-c6U\",
  \"sizeDescription\": \"Size 5wjYaS\",
  \"sizeSet\": \"SET-Zv\",
  \"orderPosition\": \"12877\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/sizes" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_15"


# Request #16 - users
PAYLOAD_16='{
  \"id\": \"400\",
  \"userNumber\": \"USR-Krh5i\",
  \"card\": \"CARDtHoSjB\",
  \"surname\": \"SurnamePB8Q\",
  \"name\": \"NameZ0eP\",
  \"clientNumber\": \"CLTx2el\",
  \"functionCode\": \"FCkG\",
  \"costCenter\": \"CCGsT\",
  \"startDate\": \"02042024\",
  \"endDate\": \"21062027\",
  \"conveyor\": \"36\",
  \"weeklyCredit\": \"90\",
  \"categoryCode\": \"CATIR\",
  \"gender\": \"M\",
  \"language\": \"it-IT\",
  \"missingSize\": \"2\",
  \"sendMessage\": \"1\",
  \"phases\": \"1\",
  \"pickUp\": \"1\",
  \"primaryConveyor\": \"4\",
  \"disableDate\": \"12062025\",
  \"newUserCode\": \"NEWHgiM\",
  \"email\": \"userDp7u@test.com\",
  \"workShift\": \"C\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/users" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_16"


# Request #17 - user-models
PAYLOAD_17='{
  \"id\": \"601\",
  \"userNumber\": \"USR-XvS5T\",
  \"itemCode\": \"ITEM-tph0L\",
  \"sizeCode\": \"SZ-FRB\",
  \"creditsDirtyBin\": \"55\",
  \"weeklyCredits\": \"53\",
  \"type\": \"0\",
  \"operationFlag\": \"0\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/user-models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_17"


# Request #18 - garments
PAYLOAD_18='{
  \"id\": \"501\",
  \"chipCode\": \"CHIP-ser9H79O\",
  \"barcode\": \"BARrYi9DVGqKI\",
  \"itemCode\": \"ITEM-5s5Co\",
  \"sizeCode\": \"SZ-DyF\",
  \"personalNumber\": \"PN1qsT\",
  \"client\": \"CLTxpT\",
  \"conveyor\": \"17\",
  \"storagesGroup\": \"SG2i\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/garments" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_18"


# Request #19 - models
PAYLOAD_19='{
  \"id\": \"100\",
  \"modelCode\": \"MDL-SYL2sR\",
  \"modelShortDescription\": \"Short vETmTqX8\",
  \"modelLongDescription\": \"Long description xjVCEe0uZXy2\",
  \"occupation\": \"1\",
  \"fromDate\": \"26102024\",
  \"toDate\": \"14082024\",
  \"hungType\": \"2\",
  \"modelType\": \"2\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_19"


# Request #20 - user-categories
PAYLOAD_20='{
  \"id\": \"200\",
  \"categoryCode\": \"CAT-4iGh\",
  \"categoryDescription\": \"Category 3ZOWnEm8Kc\",
  \"itemCode\": \"ITEM-a1j0\",
  \"dailyCredit\": \"94\",
  \"weeklyCredit\": \"72\",
  \"dotationType\": \"0\"
}'
curl --noprox '*' -s -X POST "$BASE_URL/user-categories" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d "$PAYLOAD_20"

