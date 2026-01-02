#!/bin/bash
set -e

export NO_PROXY="*"

BASE_URL="http://localhost:6060"

echo "Sending FULL B2K dataset to $BASE_URL ..."
echo "NO_PROXY=$NO_PROXY"
echo "----------------------------------------------------"

###############################################
# 100 / 101 — MODELS
###############################################
curl --noproxy '*' -X POST "$BASE_URL/import/models" \
  -H "Content-Type: application/json" \
  -d '{
        "id": "100",
        "modelCode": "MOD001",
        "shortDescription": "Blouse",
        "longDescription": "Long sleeve blouse",
        "occupation": "01",
        "fromDate": "01012024",
        "toDate": "31122024",
        "hungType": "01",
        "modelType": "02"
      }'
echo -e "\n→ Sent 100 Model"


###############################################
# 110 / 111 — MODEL/STORAGE
###############################################
#curl --noproxy '*' -X POST "$BASE_URL/import/models" \
#  -H "Content-Type: application/json" \
#  -d '{
#        "id": "110",
#        "modelCode": "MOD001",
#        "modelUse": "A",
#        "conveyorCode": "01"
#      }'
#echo -e "\n→ Sent 110 Model/Storage"


###############################################
# 200 / 201 — CATEGORIES
###############################################
curl --noproxy '*' -X POST "$BASE_URL/import/categories" \
  -H "Content-Type: application/json" \
  -d '{
        "id": "200",
        "categoryCode": "CAT001",
        "categoryDescription": "Nurses",
        "itemCode": "ITM0001",
        "dailyCredit": "02",
        "weeklyCredit": "10",
        "dotationType": "01"
      }'
echo -e "\n→ Sent 200 Category"


###############################################
# 210 / 211 — CATEGORY/MODEL
###############################################
#curl --noproxy '*' -X POST "$BASE_URL/import/categories" \
#  -H "Content-Type: application/json" \
#  -d '{
#        "id": "210",
#        "modelCode": "MOD001",
#        "categoryCode": "CAT001",
#        "dailyCredit": "02",
#        "weeklyCredit": "10",
#        "dotationType": "01"
#      }'
#echo -e "\n→ Sent 210 Category/Model"


###############################################
# 300 / 301 — MODEL SIZES
###############################################
curl --noproxy '*' -X POST "$BASE_URL/import/sizes" \
  -H "Content-Type: application/json" \
  -d '{
        "id": "300",
        "modelCode": "MOD001",
        "sizeCode": "SIZE-L",
        "sizeDescription": "Large",
        "sizeSet": "SET1",
        "orderPosition": "00010"
      }'
echo -e "\n→ Sent 300 Model Size"


###############################################
# 400 / 401 — CLIENTS / USERS
###############################################
curl --noproxy '*' -X POST "$BASE_URL/import/clients" \
  -H "Content-Type: application/json" \
  -d '{
        "id": "400",
        "userNumber": "USR001",
        "card": "CARD00123456789",
        "surname": "DUPONT",
        "name": "JEAN",
        "clientNumber": "CL00001",
        "functionCode": "F001",
        "costCenter": "CC001",
        "startDate": "01012024",
        "endDate": "31122099",
        "conveyor": "01",
        "weeklyCredit": "05",
        "categoryCode": "CAT001",
        "gender": "M",
        "language": "FR",
        "missingSize": "N",
        "sendMessage": "Y",
        "phases": "1",
        "pickup": "1",
        "primaryConveyor": "01",
        "disableDate": "00000000",
        "newUserCode": "USRNEW001",
        "email": "jean.dupont@example.com",
        "workShift": "DAY"
      }'
echo -e "\n→ Sent 400 Client/User"


###############################################
# 410 / 411 — USER/CONVEYOR
###############################################
#curl --noproxy '*' -X POST "$BASE_URL/import/clients" \
#  -H "Content-Type: application/json" \
#  -d '{
#        "id": "410",
#        "userNumber": "USR001",
#        "conveyorCode": "01",
#        "gateCode": "01",
#        "primary": "Y",
#        "assignSlot": "Y"
#      }'
#echo -e "\n→ Sent 410 Conveyor/User"


###############################################
# 420 / 421 — USER/CATEGORY
###############################################
#curl --noproxy '*' -X POST "$BASE_URL/import/categories" \
#  -H "Content-Type: application/json" \
#  -d '{
#        "id": "420",
#        "userNumber": "USR001",
#        "categoryCode": "CAT001",
#        "primary": "Y",
#        "enabled": "Y"
#      }'
#echo -e "\n→ Sent 420 Category/User"


###############################################
# 500 / 501 — CHIPS
###############################################
curl --noproxy '*' -X POST "$BASE_URL/import/chips" \
  -H "Content-Type: application/json" \
  -d '{
        "id": "500",
        "chipCode": "CHIP0012345678",
        "barcode": "BAR0012345678",
        "itemCode": "ITM0001",
        "sizeCode": "SIZE-L",
        "personalNumber": "PN0001",
        "client": "CL00001",
        "conveyor": "01",
        "storagesGroup": "SG01"
      }'
echo -e "\n→ Sent 500 Chip"


###############################################
# 520 — RETURNS
###############################################
curl --noproxy '*' -X POST "$BASE_URL/import/chips" \
  -H "Content-Type: application/json" \
  -d '{
        "id": "520",
        "chipCode": "CHIP0012345678"
      }'
echo -e "\n→ Sent 520 Return"


###############################################
# 600 / 601 — USER/MODEL LINK
###############################################
#curl --noproxy '*' -X POST "$BASE_URL/import/models" \
#  -H "Content-Type: application/json" \
#  -d '{
#        "id": "600",
#        "userNumber": "USR001",
#        "itemCode": "ITM0001",
#        "sizeCode": "SIZE-L",
#        "creditsDirtyBin": "01",
#        "weeklyCredits": "05",
#        "type": "A",
#        "operationFlag": "U"
#      }'
#echo -e "\n→ Sent 600 User/Model Link"


###############################################
# 900 / 901 — FUNCTIONS
###############################################
curl --noproxy '*' -X POST "$BASE_URL/import/functions" \
  -H "Content-Type: application/json" \
  -d '{
        "id": "900",
        "functionCode": "F001",
        "functionDescription": "Nurse"
      }'
echo -e "\n→ Sent 900 Function"


echo "----------------------------------------------------"
echo "ALL B2K data sent successfully!"
