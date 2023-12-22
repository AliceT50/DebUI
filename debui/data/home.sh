#!/bin/bash

# Application linecolor bleu
linecolor=${BLUE}
echo -e "${linecolor}"

# okpfozpkqpf
show_box() 
{
    clear
    horizontal_line_up
    sed -n '3p' "$datafile" | while read -r line; do
        centered_text "$line"
    done
    sed -n '30p' "$datafile" | while read -r line; do
        centered_text "$line"
    done
    centered_text " "
    sed -n '31p' "$datafile" | while read -r line; do
        centered_text "$line"
    done
    horizontal_line_middle
    sed -n '32p' "$datafile" | while read -r line; do
        centered_text "$line "
    done
    sed -n '33p' "$datafile" | while read -r line; do
        centered_text "$line "
    done
    horizontal_line_down
}
show_box

echo -e "${RESET}"
read -n1 -p "$option_message" choice1

case $choice1 in
    1)
        source /home/$USER/debui/data/functions/f1.sh
        ;;
    2)
        source /home/$USER/debui/data/functions/f2.sh
        ;;
    3)
        echo "Fin du script."
        exit 0
        ;;
    *)
        echo "Option invalide. Veuillez choisir une option valide."
        ;;
esac

read -p "Appuyez sur Entrée pour continuer..."