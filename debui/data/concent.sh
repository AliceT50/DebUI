#!/bin/bash

# Partie 1.1 - Application linecolor RED
linecolor=${RED}
echo -e "${RED}"

# Partie 1.2 - Box consentement
show_box() 
{
    clear
    horizontal_line_up
    sed -n '10p' "$datafile" | while read -r line; do
        centered_text "$line"
    done
    centered_text " "
    sed -n '11p' "$datafile" | while read -r line; do
        centered_text "$line"
    done
    sed -n '12p' "$datafile" | while read -r line; do
        centered_text "$line"
    done
    sed -n '13p' "$datafile" | while read -r line; do
        centered_text "$line"
    done
    sed -n '14p' "$datafile" | while read -r line; do
        centered_text "$line"
    done
    sed -n '15p' "$datafile" | while read -r line; do
        centered_text "$line "
    done
    centered_text " "
    sed -n '16p' "$datafile" | while read -r line; do
        centered_text "$line"
    done
    sed -n '17p' "$datafile" | while read -r line; do
        centered_text "$line "
    done
    horizontal_line_down
}
show_box

# Script 1.2 - Choix consentement exécution script
echo -e "${RESET}"
read -n1 -p "$option_message" acceptscript
case $acceptscript in
    [1yY])
        echo -e "\n"
        ;;
    *)
        echo -e "\n"
        linecolor=${RED}
        echo -e "${linecolor}ERREUR 1.1${RESET} Refus consentement charte DebUI."
        echo -e "${RESET}"
        exit 0
        ;;
esac