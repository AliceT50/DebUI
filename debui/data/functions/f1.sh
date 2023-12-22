#!/bin/bash

echo -e "\n"
echo $password | sudo -S apt-get update && sudo -S apt-get upgrade -y && sudo -S flatpak update -y
echo -e "\n${GREEN}Mise à jour exécutée avec succès !${RESET}"