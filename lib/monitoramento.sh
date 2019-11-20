#!/bin/bash
clear
logo(){
	clear
	echo -e "=========================================================================="
	echo -e "                                MONITORING                            "
	echo -e "=========================================================================="
	echo -e "\033[01;31m=========================================================================="
}

logo
echo -ne "\n\033[01;32m==========================================================================\n\n [1] To monitor the entire perimeter.\n [2] To monitor a specific network.\n\n==========================================================================\n\n\033[00;34mEnter the option: \033[00;37m";read opcao

# Função responsável por monitorar todo o perimetro em alcançe.
fun_perimetro() {
	clear
	logo
	echo -ne "\n\033[00;33m Inform the network interface in monitor mode: \033[00;37m";read iface
	
	# Abre o monitoramento em um novo terminal para dar facilidade ao usuário no momento de copia de informações e análises
	gnome-terminal --geometry=120x40 --hide-menubar --window -x bash -c "airodump-ng $iface" &>/dev/null && flag=0 && flag=1

	source lib/monitoramento.sh
}

# Função responsável por monitorar apenas uma rede em especifico e armazenar todos os dados em um arquivo.
fun_especifica() {
	clear
	logo
	echo -ne "\n\033[00;33m Enter the BSSID of the network: \033[00;37m";read id_rede
	echo -ne "\n\033[00;33m Inform the CHANNEL that the network is using: \033[00;37m";read cha_rede
	echo -ne "\n\033[00;33m Enter file name to save all network traffic: \033[00;37m";read traf_rede
	echo -ne "\n\033[00;33m Inform the network interface in monitor mode: \033[00;37m";read iface

	# Abre o monitoramento em um novo terminal para dar facilidade ao usuário no momento de copia de informações e análises.
	gnome-terminal --geometry=120x40 --hide-menubar --window -x bash -c "airodump-ng --wps -c $cha_rede --bssid $id_rede -w handshakes/$traf_rede $iface" &>/dev/null && flag=0 && flag=1
	
	source lib/monitoramento.sh
}

case $opcao in
	1) # chamada da função fun_perimetro.
	fun_perimetro
	;;
	2) # chamada da função fun_especifica.
	fun_especifica
	;;
	*) # chama a biblioteca monitoramento se acaso o usuário informar uma opção errada.
	clear
	source lib/monitoramento.sh 
	;;
esac