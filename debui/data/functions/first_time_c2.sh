#!/bin/bash

if [ $flatpak_installed = true ]; then
    echo -e "aucun changement"
else
    echo $password | sudo -S apt-get install flatpak gnome-software-plugin-flatpak plasma-discover-backend-flatpak -y 
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo -e "installation de flatpak terminée. Afin de profiter de flatpak pleinement, il est nécessaire de redémarrer la machine."
fi

if [ $snap_installed = true ]; then
    snap_list=$(snap list | awk 'NR>1 {print $1}')
    
    for package in $snap_list; do
        echo $password | sudo -S snap remove --purge $package

        if [ "$package" = "firefox" ]; then
            firefox_installed=true
        fi
    done

    # Remove remaining snap dependencies
    dependencies=$(sudo snap list --all | awk 'NR>1 {print $1}')
    for dependency in $dependencies; do
        echo $password | sudo -S snap remove --purge $dependency
    done
    echo $password | sudo -S apt-get remove --auto-remove snapd 
    echo $password | sudo -S rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd /usr/lib/snapd
    echo -e "Package: snapd\nPin: release a=*\nPin-Priority: -10" | sudo -S tee /etc/apt/preferences.d/nosnap.pref <<< "$password"
    echo $password | sudo -S apt-get update
    echo $password | sudo -S apt install --install-suggests gnome-software
    if [ $firefox_installed = true ]; then
        echo $password | sudo -S add-apt-repository -y ppa:mozillateam/ppa && sudo -S apt-get update && sudo apt-get install -t 'o=LP-PPA-mozillateam' firefox
        echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo -S tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox <<< "$password"
        echo -e "Package: firefox*\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 501" sudo -S tee /etc/apt/preferences.d/mozillateamppa <<< "$password"
    fi
    echo -e "Snap a été désinstallé"
else
    echo -e "Snap n'est pas présent sur le système"
fi