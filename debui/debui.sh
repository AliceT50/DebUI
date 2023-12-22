#!/bin/bash

## Variables Système
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\e[0;34m'
    TITLE='\e[1;37m'
    RESET='\033[0m'
    linecolor=${RED}
    datafile="/home/$USER/debui/data.txt"
    option_message=$(sed -n '18p' "$datafile")
    distribution=$(grep "distribution =" "$datafile" | awk '{print $3}')
    version=$(sed -n '5s/version = //p' "$datafile")
    snap_installed=$(sed -n '7s/snap_installed = //p' "$datafile")
    flatpak_installed=$(sed -n '6s/flatpak_installed = //p' "$datafile")

#---------------------------------------------------------------------------------------------------------------------------------------#

## Fonction script 1 - Configuration de la box par rapport aux dimensions de la fenêtre
    # Fonction script 1.1 - génération ligne horizontale haute
    horizontal_line_up() {
        local width=$(tput cols)
        local line="╭"
        for ((i = 0; i < width - 2; i++)); do
            line="${line}─"
        done
        line="${line}╮"
        echo "$line"
    }
    # Fonction script 1.2 - génération ligne horizontale basse
    horizontal_line_middle() {
        local width=$(tput cols)
        local line="│"
        for ((i = 0; i < width - 2; i++)); do
            line="${line}─"
        done
        line="${line}│"
        echo "$line"
    }
    # Fonction script 1.2 - génération ligne horizontale basse
    horizontal_line_down() {
        local width=$(tput cols)
        local line="╰"
        for ((i = 0; i < width - 2; i++)); do
            line="${line}─"
        done
        line="${line}╯"
        echo "$line"
    }

    # Fonction script 1.3 - génération texte centré dans la boîte (barres verticales)
    centered_text() {
        local text="$1"
        local width=$(tput cols)
        local padding=$((($width - ${#text} - 5) / 2))
        echo -e "│$(printf '%*s' $padding) ${RESET}$text${linecolor} $(printf '%*s' $padding) │"
    }

#---------------------------------------------------------------------------------------------------------------------------------------#

## Partie 1 - Fonction consentement script
if grep -q "concent = true" "$datafile"; then
    :
else
    source /home/$USER/debui/data/concent.sh
    sed -i '0,/^concent = false/s//concent = true/' "$datafile"
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

# Partie 2 - Demande le mot de passe Sudo
read -sp "Entrez votre mot de passe sudo : " password
if (echo "$password" | sudo -S -v -k > /dev/null 2>&1) ; then
    sed -n '70p' "$datafile"
    sed -n '71p' "$datafile"
    echo -e "${linecolor}"
else
    echo -e ""
    sed -n '72p' "$datafile"
    sed -n '73p' "$datafile"
    linecolor=${RED}
    echo -e "${linecolor}ERREUR 2.1${RESET} Sudo impossible / Mauvais mot de passe."
    echo -e "${RESET}"
    exit 0
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

## Partie 3 - first_time
if grep -q "first-time = false" "$datafile"; then
    :
else
    source /home/$USER/debui/data/first_time.sh
    sed -i '0,/^first-time = true/s//first-time = false/' "$datafile"
    exit 0
fi

#---------------------------------------------------------------------------------------------------------------------------------------#

## Fonction "main" - Fenêtre principale
main() {
    while true; do
        source /home/$USER/debui/data/home.sh
    done
}

# Appel de la fonction principale
main
