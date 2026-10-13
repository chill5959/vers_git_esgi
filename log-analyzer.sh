#!/bin/bash
fichier="$1"

## vérifier si le fichier existe 
if [ -e "$fichier" ]
then
    echo "le journal $fichier existe"
else
    echo "fichier journal inexistant"
    exit 1
fi

##compter le nombre de caractères :
NB=$(wc -l < "$fichier")
echo "Le fichier contient $NB lignes"

## identifier les lignes qui ont des warnings ou des avertissements 
NB_ERREURS=$(grep -c -i "error" "$fichier")
NB_WARNINGS=$(grep -c -i "warning" "$fichier")

LIGNES_ERREURS=$(grep -n -i "error" "$fichier" | cut -d: -f1 | tr '\n' ' ')
LIGNES_WARNINGS=$(grep -n -i "warning" "$fichier" | cut -d: -f1 | tr '\n' ' ')

{
echo "===== RAPPORT ====="
echo "Fichier : $fichier"
echo "Erreurs : $NB_ERREURS (lignes : $LIGNES_ERREURS)"
echo "Warnings : $NB_WARNINGS (lignes : $LIGNES_WARNINGS)"
echo "==================="
} >> rrapport_$(date '+%Y%m%d_%H%M%S').txt