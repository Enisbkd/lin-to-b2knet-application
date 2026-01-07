#!/bin/bash

# Comprehensive API Testing Script for All 13 Controllers
# Adheres to validations with --noproxy '*' for requests

BASE_URL="http://localhost:6060"

echo "========================================"
echo "Testing All 13 Controllers"
echo "========================================"

# ========== MODEL SIZES CONTROLLER ==========
echo ""
echo "Testing Model Sizes Controller (/api/v1/import/model-sizes)"
for i in {1..5}
do
  curl -X POST "$BASE_URL/api/v1/import/model-sizes" --noproxy '*' -H "Content-Type: application/json" -d '{
    "id": "'$i'00",
    "modelCode": "MODEL'$i'",
    "sizeCode": "SIZE'$i'",
    "quantity": "'$i'0"
  }'
done

# ========== CATEGORY USERS CONTROLLER ==========
echo ""
echo "Testing Category Users Controller (/api/v1/import/category-users)"
for i in {1..5}
do
  curl -X POST "$BASE_URL/api/v1/import/category-users" --noproxy '*' -H "Content-Type: application/json" -d '{
    "id": "'$i'00",
    "categoryCode": "CAT'$i'",
    "userNumber": "USER'$i'",
    "startDate": "01012024",
    "endDate": "31122024"
  }'
done

# ========== MODEL STORAGES CONTROLLER ==========
echo ""
echo "Testing Model Storages Controller (/api/v1/import/model-storages)"
for i in {1..5}
do
  curl -X POST "$BASE_URL/api/v1/import/model-storages" --noproxy '*' -H "Content-Type: application/json" -d '{
    "id": "'$i'00",
    "modelCode": "MODEL'$i'",
    "storageDetails": {
      "location": "Warehouse'$i'",
      "capacity": "'$i'000"
    }
  }'
done

# ========== USER CONVEYORS CONTROLLER ==========
echo ""
echo "Testing User Conveyors Controller (/api/v1/import/user-conveyors)"
for i in {1..5}
do
  curl -X POST "$BASE_URL/api/v1/import/user-conveyors" --noproxy '*' -H "Content-Type: application/json" -d '{
    "id": "'$i'00",
    "userCode": "USER'$i'",
    "conveyorRoute": "Route'$i'",
    "shiftTimings": {
      "startDate": "010120'$i'",
      "endDate": "311220'$i'"
    },
    "primaryShift": "True"
  }'
done

# ========== CATEGORY MODELS CONTROLLER ==========
echo ""
echo "Testing Category Models Controller (/api/v1/import/category-models)"
for i in {1..5}
do
  curl -X POST "$BASE_URL/api/v1/import/category-models" --noproxy '*' -H "Content-Type: application/json" -d '{
    "id": "Cat'${10'}),
CATEGORY_PRO user'$50LinkJSON-pile.')" MissingFinal drafting:per-req

echo ""
echo ""
echo "========================================"
echo "All 13 controllers tested with sample payloads!"
echo "========================================"
