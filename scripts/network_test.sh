#!/bin/bash

write_section() {
    echo ""
    echo "===== $1 ====="
}

get_target() {
    if [ -n "$1" ]; then
        echo "$1"
        return
    fi

    read -r -p "Entrez la machine distante a tester (ex: 8.8.8.8 ou google.com) : " target
    echo "$target"
}

show_network_info() {
    write_section "Informations reseau de la machine"
    echo "Date du test : $(date)"
    echo "Nom de la machine : $(hostname)"

    write_section "Adresses IP configurees"
    if command -v ip >/dev/null 2>&1; then
        ip -o addr show | awk '{print $2 " - " $3 " - " $4}'
    elif command -v ifconfig >/dev/null 2>&1; then
        ifconfig
    elif command -v hostname >/dev/null 2>&1; then
        hostname -I 2>/dev/null
    else
        echo "Impossible de recuperer les adresses IP : aucune commande compatible trouvee."
    fi

    write_section "Route par defaut"
    if command -v ip >/dev/null 2>&1; then
        ip route show default
    elif command -v route >/dev/null 2>&1; then
        route -n
    else
        echo "Impossible de recuperer la route par defaut."
    fi
}

test_remote_access() {
    local target="$1"

    write_section "Test d'accessibilite"

    if [ -z "$target" ]; then
        echo "Echec : aucune cible n'a ete indiquee."
        echo "Utilisation : ./network_test.sh <adresse_ip_ou_nom_de_domaine>"
        return 1
    fi

    echo "Cible testee : $target"

    if ping -c 4 -W 2 "$target" >/dev/null 2>&1; then
        echo "Resultat : succes, la machine '$target' est accessible."
        return 0
    fi

    echo "Resultat : echec, la machine '$target' n'est pas accessible."
    echo "Causes possibles : cible incorrecte, machine eteinte, pare-feu, DNS indisponible ou probleme reseau."
    return 1
}

main() {
    local target

    target="$(get_target "$1")"

    show_network_info
    test_remote_access "$target"
}

main "$1"
