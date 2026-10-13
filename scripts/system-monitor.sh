#!/bin/bash

source ./config/toolkit.conf

# Création du répertoire des rapports s'il n'existe pas
mkdir -p "$REPORT_DIR"
RAPPORT="$REPORT_DIR/system-monitor_$(date +%Y%m%d_%H%M%S).txt"

{
    echo "===== RAPPORT DE SURVEILLANCE SYSTÈME ====="
    echo
    echo "--- Nom du serveur ---"
    hostname
    echo
    echo "--- Date et heure ---"
    date "+%d/%m/%Y %H:%M:%S"
    echo
    echo "--- Utilisation de la mémoire ---"
    free -h
    echo
    echo "--- Systèmes de fichiers ---"
    df -h
    echo
    echo "--- Charge du système ---"
    uptime
    echo
    
    if [ "$ALERTS_ENABLED" = "true" ]; then
        echo "--- Alertes ---"

        # Pourcentage utilisé du disque principal
        DISQUE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
        if [ "$DISQUE" -ge "$DISK_ALERT_THRESHOLD" ]; then
            echo "ALERTE : disque utilisé à $DISQUE%"
        fi

        # Pourcentage de mémoire utilisée
        MEMOIRE=$(free | awk 'NR==2 {print int($3/$2*100)}')
        if [ "$MEMOIRE" -ge "$MEMORY_ALERT_THRESHOLD" ]; then
            echo "ALERTE : mémoire utilisée à $MEMOIRE%"
        fi
        echo
    fi

    echo "==========================================="
} | tee "$RAPPORT"

echo
echo "Rapport enregistré dans : $RAPPORT"