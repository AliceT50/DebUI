#!/bin/bash

# Partie 3.1 - Application linecolor GREEN
linecolor=${GREEN}
echo -e "${linecolor}"

# Partie 3.2 - Box first_time
show_box() 
{
    clear
    horizontal_line_up
    sed -n '50p' "$datafile" | while read -r line; do
        centered_text "$line "
    done
    sed -n '51p' "$datafile" | while read -r line; do
        centered_text "$line "
    done
    sed -n '52p' "$datafile" | while read -r line; do
        centered_text "$line"
    done
    horizontal_line_down
}
show_box
echo -e "\n"
sed -n '53p' "$datafile"

# Partie 3.3 - Trouver et assigner distribution système
# Partie 3.3.1 - Trouver la distribution Debian automatiquement.
if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [ -n "$ID" ]; then
        case "$ID" in
            debian)
                sed -i '0,/^distribution = none/s//distribution = debian/' "$datafile"
                echo -e ""
                sed -n '54p' "$datafile" && sed -n '4p' "$datafile"
                ;;
            ubuntu)
                sed -i '0,/^distribution = none/s//distribution = ubuntu/' "$datafile"
                echo -e ""
                sed -n '54p' "$datafile" && sed -n '4p' "$datafile"
                ;;
            *)
                linecolor=${RED}
                echo -e "${linecolor}ERREUR 3.1${RESET} Distribution inconnue : $ID"
                exit 0
                ;;
        esac
    else
        echo -e "${linecolor}ERREUR 3.2${RESET} Impossible de déterminer la distribution."
        exit 0
    fi
else
    echo -e "${linecolor}ERREUR 3.3${RESET} Fichier /etc/os-release introuvable. La détection de la distribution est impossible."
    exit 0
fi

# Partie 3.3.2 - Déclarer variable distribution

distribution=$(grep "distribution =" "$datafile" | awk '{print $3}')

# Partie 3.4 - Récupération version de la distribution

version=$(lsb_release -rs)
sed -i '5s/version = none/version = '"$version"'/g' "$datafile"

# Partie 3.5 - Détection et choix gestionnaire(s) de paquets
# Partie 3.5.1 - Vérifie si Flatpak est installé
if [ -x "$(command -v flatpak)" ]; then
    sed -i '0,/^flatpak_installed = false/s//flatpak_installed = true/' "$datafile"
    flatpak_installed=true
else
    flatpak_installed=false
fi

# Partie 3.5.2 - Vérifie si Snap est installé
if [ -x "$(command -v snap)" ]; then
    sed -i '0,/^snap_installed = false/s//snap_installed = true/' "$datafile"
    snap_installed=true
else
    snap_installed=false
fi

# Partie 3.5.3 - Box gestionnaire(s) de paquets.

echo -e "\n${linecolor} Q.1 - ${RESET}$(sed -n '57p' "$datafile")"
echo -e "$(sed -n '58p' "$datafile")"
echo -e "$(sed -n '59p' "$datafile")"
echo -e "$(sed -n '60p' "$datafile")"
echo -e "$(sed -n '61p' "$datafile")\n"

# Partie 3.5.4 - Choix gestionnaire(s) de paquets.
echo -e "${RESET}"
read -n1 -p "$option_message" first_time_1
case $first_time_1 in
    [2bB])
        echo -e "\n"
        source /home/$USER/debui/data/functions/first_time_c2.sh
        ;;
    [3cC])
        echo -e "\n"
        source /home/$USER/debui/data/functions/first_time_c3.sh
        ;;
    [4dD])
        echo -e "\n"
        source /home/$USER/debui/data/functions/first_time_c4.sh
        ;;
    *)
        echo -e "\n"
        echo -e "\n${linecolor}End 3.5 - ${RESET}Aucune modification apportée au système"
        ;;
esac