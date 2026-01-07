#!/bin/bash
set -e

export NO_PROXY="*"

BASE_URL="http://localhost:6060"

echo "Sending 100 random employees to $BASE_URL/api/v1/import/employees ..."
echo "NO_PROXY=$NO_PROXY"
echo "----------------------------------------------------"

# Arrays for random data generation
FIRST_NAMES=("John" "Jane" "Michael" "Sarah" "David" "Emily" "Robert" "Lisa" "James" "Maria" "William" "Jennifer" "Richard" "Linda" "Thomas" "Patricia" "Charles" "Barbara" "Daniel" "Susan")
LAST_NAMES=("Smith" "Johnson" "Williams" "Brown" "Jones" "Garcia" "Miller" "Davis" "Rodriguez" "Martinez" "Hernandez" "Lopez" "Gonzalez" "Wilson" "Anderson" "Thomas" "Taylor" "Moore" "Jackson" "Martin")
GENDERS=("M" "F")
LANGUAGES=("en-US" "fr-FR" "es-ES" "de-DE" "it-IT")
CATEGORIES=("CAT001" "CAT002" "CAT003" "CAT004" "CAT005")
FUNCTIONS=("F001" "F002" "F003" "F004" "F005")
SHIFTS=("SH001" "SH002" "SH003")
CHANGE_SIZES=("0" "1" "2")
PRIMARY_MAGS=("0" "1")

# Function to generate random date in ddMMyyyy format
generate_random_date() {
    local year=$((2024 + RANDOM % 2))  # 2024 or 2025
    local month=$(printf "%02d" $((1 + RANDOM % 12)))
    local day=$(printf "%02d" $((1 + RANDOM % 28)))
    echo "${day}${month}${year}"
}

# Generate and post 100 employees
for i in $(seq 1 100); do
    # Generate random employee data
    EMPLOYEE_CODE=$(printf "EMP%05d" $i)
    CARD_CODE=$(printf "CARD%012d" $((1000000000 + RANDOM % 900000000)))
    FIRST_NAME=${FIRST_NAMES[$RANDOM % ${#FIRST_NAMES[@]}]}
    LAST_NAME=${LAST_NAMES[$RANDOM % ${#LAST_NAMES[@]}]}
    GENDER=${GENDERS[$RANDOM % ${#GENDERS[@]}]}
    LANGUAGE=${LANGUAGES[$RANDOM % ${#LANGUAGES[@]}]}
    CATEGORY=${CATEGORIES[$RANDOM % ${#CATEGORIES[@]}]}
    FUNCTION=${FUNCTIONS[$RANDOM % ${#FUNCTIONS[@]}]}
    SHIFT=${SHIFTS[$RANDOM % ${#SHIFTS[@]}]}
    CHANGE_SIZE=${CHANGE_SIZES[$RANDOM % ${#CHANGE_SIZES[@]}]}
    CONTRACT_START=$(generate_random_date)
    CONTRACT_END="31122099"
    MAG=$(printf "%02d" $((1 + RANDOM % 10)))
    PRIMARY_MAG=${PRIMARY_MAGS[$RANDOM % ${#PRIMARY_MAGS[@]}]}

    # Create JSON payload
    JSON_PAYLOAD=$(cat <<EOF
{
  "code": "$EMPLOYEE_CODE",
  "cardCode": "$CARD_CODE",
  "lastName": "$LAST_NAME",
  "firstName": "$FIRST_NAME",
  "categoryCode": "$CATEGORY",
  "categoryDescription": "Category $CATEGORY Description",
  "functionCode": "$FUNCTION",
  "functionDescription": "Function $FUNCTION Description",
  "shiftCode": "$SHIFT",
  "shiftDescription": "Shift $SHIFT Description",
  "gender": "$GENDER",
  "language": "$LANGUAGE",
  "changeSize": "$CHANGE_SIZE",
  "contractStart": "$CONTRACT_START",
  "contractEnd": "$CONTRACT_END",
  "mag": "$MAG",
  "primaryMag": "$PRIMARY_MAG"
}
EOF
)

    # Send POST request
    curl --noproxy '*' -X POST "$BASE_URL/api/v1/import/employees" \
      -H "Content-Type: application/json" \
      -d "$JSON_PAYLOAD"

    echo -e "\n→ Sent employee $i/$100: $EMPLOYEE_CODE ($FIRST_NAME $LAST_NAME)"

    # Small delay to avoid overwhelming the server (optional)
    sleep 0
done

echo "----------------------------------------------------"
echo "All 100 employees sent successfully!"
