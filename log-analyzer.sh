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
