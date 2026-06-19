#!/bin/bash
# Auto-generated curl requests
# Simple curl commands with variables

set -euo pipefail

# ========== CONFIGURATION ==========
HOST="http://localhost:6060"
API_KEY="your-api-key-here"
CONVEYOR="02"
BASE_URL="$HOST/api/v1/import/$CONVEYOR"
# ==================================


# Request #1 - models
curl --noproxy '*' -s -X POST "$BASE_URL/models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "101",
  "modelCode": "MDL-FPw5vc",
  "modelShortDescription": "Short rqgLDMhH",
  "modelLongDescription": "Long description sBOsjum0hE2L",
  "occupation": "2",
  "fromDate": "24062026",
  "toDate": "28012025",
  "hungType": "0",
  "modelType": "2"
}'


# Request #2 - user-categories
curl --noproxy '*' -s -X POST "$BASE_URL/user-categories" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "201",
  "categoryCode": "CAT-to6l",
  "categoryDescription": "Category VTR0b6QpUi",
  "itemCode": "ITEM-EIz1",
  "dailyCredit": "53",
  "weeklyCredit": "13",
  "dotationType": "0"
}'


# Request #3 - sizes
curl --noproxy '*' -s -X POST "$BASE_URL/sizes" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "300",
  "modelCode": "MDL-Lp7DPh",
  "sizeCode": "SZ-Jkz",
  "sizeDescription": "Size yRTuhW",
  "sizeSet": "SET-Of",
  "orderPosition": "14416"
}'


# Request #4 - users
curl --noproxy '*' -s -X POST "$BASE_URL/users" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "400",
  "userNumber": "USR-FEbno",
  "card": "CARDTSRcRx",
  "surname": "SurnamefRWx",
  "name": "NameJKoO",
  "clientNumber": "CLTTJLm",
  "functionCode": "FC0v",
  "costCenter": "CCVV0",
  "startDate": "06042028",
  "endDate": "08022028",
  "conveyor": "56",
  "weeklyCredit": "34",
  "categoryCode": "CATpa",
  "gender": "M",
  "language": "it-IT",
  "missingSize": "2",
  "sendMessage": "2",
  "phases": "1",
  "pickUp": "0",
  "primaryConveyor": "56",
  "disableDate": "27012028",
  "newUserCode": "NEWDoRs",
  "email": "user9Fqm@test.com",
  "workShift": "B"
}'


# Request #5 - user-models
curl --noproxy '*' -s -X POST "$BASE_URL/user-models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "601",
  "userNumber": "USR-lOVLW",
  "itemCode": "ITEM-VhTts",
  "sizeCode": "SZ-0Cm",
  "creditsDirtyBin": "24",
  "weeklyCredits": "46",
  "type": "0",
  "operationFlag": "0"
}'


# Request #6 - garments
curl --noproxy '*' -s -X POST "$BASE_URL/garments" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "501",
  "chipCode": "CHIP-WJwhy6dB",
  "barcode": "BARARtCiYvILs",
  "itemCode": "ITEM-2y3Sh",
  "sizeCode": "SZ-Q2i",
  "personalNumber": "PNbqWT",
  "client": "CLTrO2",
  "conveyor": "76",
  "storagesGroup": "SGGK"
}'


# Request #7 - models
curl --noproxy '*' -s -X POST "$BASE_URL/models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "100",
  "modelCode": "MDL-uIEp25",
  "modelShortDescription": "Short x81iSJiz",
  "modelLongDescription": "Long description AvoZZOxfVlu2",
  "occupation": "1",
  "fromDate": "24012027",
  "toDate": "13062025",
  "hungType": "1",
  "modelType": "0"
}'


# Request #8 - user-categories
curl --noproxy '*' -s -X POST "$BASE_URL/user-categories" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "201",
  "categoryCode": "CAT-NTix",
  "categoryDescription": "Category K0viMAsVkW",
  "itemCode": "ITEM-jCXv",
  "dailyCredit": "78",
  "weeklyCredit": "42",
  "dotationType": "0"
}'


# Request #9 - sizes
curl --noproxy '*' -s -X POST "$BASE_URL/sizes" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "301",
  "modelCode": "MDL-zRpdM7",
  "sizeCode": "SZ-v0e",
  "sizeDescription": "Size LRorm6",
  "sizeSet": "SET-T2",
  "orderPosition": "13803"
}'


# Request #10 - users
curl --noproxy '*' -s -X POST "$BASE_URL/users" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "401",
  "userNumber": "USR-IBRyE",
  "card": "CARDDjMn0B",
  "surname": "SurnameuGsj",
  "name": "NameQ7AB",
  "clientNumber": "CLTaZ57",
  "functionCode": "FCBw",
  "costCenter": "CClfb",
  "startDate": "26012028",
  "endDate": "16042024",
  "conveyor": "22",
  "weeklyCredit": "69",
  "categoryCode": "CATmg",
  "gender": "M",
  "language": "it-IT",
  "missingSize": "1",
  "sendMessage": "2",
  "phases": "1",
  "pickUp": "0",
  "primaryConveyor": "71",
  "disableDate": "17102026",
  "newUserCode": "NEWgbnh",
  "email": "useritLo@test.com",
  "workShift": "A"
}'


# Request #11 - user-models
curl --noproxy '*' -s -X POST "$BASE_URL/user-models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "601",
  "userNumber": "USR-aOilD",
  "itemCode": "ITEM-YB860",
  "sizeCode": "SZ-SPH",
  "creditsDirtyBin": "82",
  "weeklyCredits": "18",
  "type": "2",
  "operationFlag": "1"
}'


# Request #12 - garments
curl --noproxy '*' -s -X POST "$BASE_URL/garments" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "500",
  "chipCode": "CHIP-8rI1GTvS",
  "barcode": "BARgsOZKvN1TY",
  "itemCode": "ITEM-ZUcAV",
  "sizeCode": "SZ-dAN",
  "personalNumber": "PNOyHI",
  "client": "CLTKeq",
  "conveyor": "59",
  "storagesGroup": "SGJf"
}'


# Request #13 - models
curl --noproxy '*' -s -X POST "$BASE_URL/models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "101",
  "modelCode": "MDL-tbUvyq",
  "modelShortDescription": "Short wk2yKorY",
  "modelLongDescription": "Long description 87WEWwCRgG6t",
  "occupation": "1",
  "fromDate": "10082025",
  "toDate": "10042028",
  "hungType": "0",
  "modelType": "2"
}'


# Request #14 - user-categories
curl --noproxy '*' -s -X POST "$BASE_URL/user-categories" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "200",
  "categoryCode": "CAT-K1tp",
  "categoryDescription": "Category 7eTRxxXyZ3",
  "itemCode": "ITEM-24Op",
  "dailyCredit": "64",
  "weeklyCredit": "39",
  "dotationType": "0"
}'


# Request #15 - sizes
curl --noproxy '*' -s -X POST "$BASE_URL/sizes" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "301",
  "modelCode": "MDL-djLfc6",
  "sizeCode": "SZ-EsC",
  "sizeDescription": "Size 5EDgeT",
  "sizeSet": "SET-TO",
  "orderPosition": "20317"
}'


# Request #16 - users
curl --noproxy '*' -s -X POST "$BASE_URL/users" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "401",
  "userNumber": "USR-OLpoQ",
  "card": "CARDfgYtFc",
  "surname": "SurnameEKLc",
  "name": "Name1lqD",
  "clientNumber": "CLTfloq",
  "functionCode": "FCN4",
  "costCenter": "CCOaT",
  "startDate": "20122024",
  "endDate": "01082025",
  "conveyor": "88",
  "weeklyCredit": "41",
  "categoryCode": "CATr0",
  "gender": "F",
  "language": "de-DE",
  "missingSize": "1",
  "sendMessage": "0",
  "phases": "0",
  "pickUp": "0",
  "primaryConveyor": "11",
  "disableDate": "14082027",
  "newUserCode": "NEWeAmE",
  "email": "userKjVQ@test.com",
  "workShift": "C"
}'


# Request #17 - user-models
curl --noproxy '*' -s -X POST "$BASE_URL/user-models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "601",
  "userNumber": "USR-3ESOC",
  "itemCode": "ITEM-FSOSw",
  "sizeCode": "SZ-mKR",
  "creditsDirtyBin": "88",
  "weeklyCredits": "24",
  "type": "2",
  "operationFlag": "0"
}'


# Request #18 - garments
curl --noproxy '*' -s -X POST "$BASE_URL/garments" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "500",
  "chipCode": "CHIP-E4RbP4FD",
  "barcode": "BARfyWRbmY14a",
  "itemCode": "ITEM-CooqF",
  "sizeCode": "SZ-Uk7",
  "personalNumber": "PNDFcr",
  "client": "CLTjqK",
  "conveyor": "15",
  "storagesGroup": "SGCU"
}'


# Request #19 - models
curl --noproxy '*' -s -X POST "$BASE_URL/models" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "101",
  "modelCode": "MDL-fsFnqd",
  "modelShortDescription": "Short 8lRrOn4B",
  "modelLongDescription": "Long description tXTqiYentq8c",
  "occupation": "1",
  "fromDate": "17102026",
  "toDate": "12012026",
  "hungType": "2",
  "modelType": "2"
}'


# Request #20 - user-categories
curl --noproxy '*' -s -X POST "$BASE_URL/user-categories" \
  -H "Content-Type: application/json" \
  -H "X-API-Key: $API_KEY" \
  -d '{
  "id": "200",
  "categoryCode": "CAT-oBC8",
  "categoryDescription": "Category MlM0Vq4JN3",
  "itemCode": "ITEM-5LYY",
  "dailyCredit": "4",
  "weeklyCredit": "51",
  "dotationType": "0"
}'

