#!/bin/sh
echo "Entrez le nom du service systemd à vérifier :"
read -r SERVICE
echo "Nous travaillons sur le service $SERVICE."
if systemctl cat "$SERVICE" >/dev/null 2>&1; then
    echo "Le service $SERVICE existe"
else
    echo "Le service $SERVICE n'existe pas"
fi
if systemctl is-active --quiet "$SERVICE"; then
    echo "Le service $SERVICE est actif"
else
    echo "Le service $SERVICE est inactif"
fi