#!/bin/bash

source ./config/toolkit.conf

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
    echo "==========================================="
} | tee "$RAPPORT"

echo
echo "Rapport enregistré dans : $RAPPORT"