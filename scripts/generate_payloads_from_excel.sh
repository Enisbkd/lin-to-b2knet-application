#!/bin/bash

#############################################
# Script pour générer des curl POST à partir d'Excel
# Prérequis: ssconvert (LibreOffice) ou python3 openpyxl
#############################################

# ===== CONFIGURATION =====
API_URL="https://localhost:6060"
API_KEY=""
EXCEL_FILE="./Wiew_export_articles_19-06-2026.xlsx"
OUTPUT_FILE="./curl_commands.sh"
CSV_TEMP="./temp_data.csv"

# Valeurs fixes
ID="100"
OCCUPATION="null"
FROM_DATE="null"
TO_DATE="null"
HUNG_TYPE="0"
MODEL_TYPE="0"

# ===== FONCTIONS =====

# Convertir Excel en CSV
convert_excel_to_csv() {
    echo "📂 Conversion du fichier Excel en CSV..."

    # Vérifier si ssconvert (LibreOffice) est disponible
    if command -v ssconvert &> /dev/null; then
        ssconvert "$EXCEL_FILE" "$CSV_TEMP" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "✅ Conversion réussie avec ssconvert"
            return 0
        fi
    fi

    # Alternative: utiliser python3
    if command -v python3 &> /dev/null; then
        python3 << PYTHON_EOF
import openpyxl
import csv
import sys

try:
    wb = openpyxl.load_workbook('$EXCEL_FILE')
    ws = wb.active

    with open('$CSV_TEMP', 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        for row in ws.iter_rows(values_only=True):
            writer.writerow(row)
    print("✅ Conversion réussie avec python3")
except Exception as e:
    print(f"❌ Erreur: {e}")
    sys.exit(1)
PYTHON_EOF
        return $?
    fi

    echo "❌ Erreur: Installez ssconvert ou python3 avec openpyxl"
    return 1
}

# Générer les commandes curl
generate_curl_commands() {
    echo "🔧 Génération des commandes curl..."

    local line_count=0
    local success_count=0
    > "$OUTPUT_FILE"

    # Ajouter le header du script
    {
        echo "#!/bin/bash"
        echo "# Script généré automatiquement - $(date)"
        echo "# Configuration:"
        echo "#   API: $API_URL"
        echo "#   Total requêtes: À compter..."
        echo ""
    } >> "$OUTPUT_FILE"

    # Traiter chaque ligne du CSV (ignorer la première ligne = en-têtes)
    while IFS=',' read -r col_A col_B col_C col_D col_E col_F col_G col_H col_I rest; do
        line_count=$((line_count + 1))

        # Ignorer la première ligne (en-têtes)
        if [ $line_count -eq 1 ]; then
            continue
        fi

        # Récupérer les valeurs des colonnes E, G, H
        # Colonne E = code article (modelCode)
        # Colonne G = Designation (modelLongDescription)
        # Colonne H = Designation courte (modelShortDescription)

        # Nettoyer les valeurs (supprimer espaces et guillemets)
        MODEL_CODE=$(echo "$col_E" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed 's/"//g')
        MODEL_LONG_DESC=$(echo "$col_G" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed 's/"//g')
        MODEL_SHORT_DESC=$(echo "$col_H" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed 's/"//g')

        # Vérifier que les données ne sont pas vides
        if [ -z "$MODEL_CODE" ] || [ -z "$MODEL_LONG_DESC" ] || [ -z "$MODEL_SHORT_DESC" ]; then
            echo "⚠️  Ligne $line_count ignorée (données manquantes)"
            continue
        fi

        success_count=$((success_count + 1))

        # Créer le payload JSON
        PAYLOAD="{\"id\": \"$ID\", \"modelCode\": \"$MODEL_CODE\", \"modelShortDescription\": \"$MODEL_SHORT_DESC\", \"modelLongDescription\": \"$MODEL_LONG_DESC\", \"occupation\": $OCCUPATION, \"fromDate\": $FROM_DATE, \"toDate\": $TO_DATE, \"hungType\": \"$HUNG_TYPE\", \"modelType\": \"$MODEL_TYPE\"}"

        # Générer la commande curl avec échappement approprié
        {
            echo "# Requête $success_count - Model: $MODEL_CODE"
            echo "curl -X POST '$API_URL' \\"
            echo "  -H 'Content-Type: application/json' \\"
            echo "  -H 'x-api-key: $API_KEY' \\"
            echo "  -d '$PAYLOAD'"
            echo ""
        } >> "$OUTPUT_FILE"

    done < "$CSV_TEMP"

    echo "✅ Génération terminée: $success_count commandes créées"
    return $success_count
}

# ===== MAIN =====

main() {
    echo "================================================"
    echo "  Générateur de curl POST depuis Excel"
    echo "================================================"
    echo ""

    # Vérifier que le fichier Excel existe
    if [ ! -f "$EXCEL_FILE" ]; then
        echo "❌ Erreur: Le fichier $EXCEL_FILE n'existe pas"
        exit 1
    fi

    # Convertir Excel en CSV
    convert_excel_to_csv
    if [ $? -ne 0 ]; then
        exit 1
    fi

    # Générer les commandes curl
    generate_curl_commands
    CURL_COUNT=$?

    # Rendre le fichier exécutable
    chmod +x "$OUTPUT_FILE"

    echo ""
    echo "================================================"
    echo "✨ Succès!"
    echo "================================================"
    echo "📁 Fichier généré: $OUTPUT_FILE"
    echo "📊 Nombre de commandes: $CURL_COUNT"
    echo ""
    echo "💡 Pour exécuter:"
    echo "   ./$OUTPUT_FILE"
    echo ""
    echo "📋 Pour voir un aperçu:"
    echo "   head -20 $OUTPUT_FILE"
    echo ""

    # Nettoyer le fichier temporaire
    rm -f "$CSV_TEMP"
}

main "$@"
