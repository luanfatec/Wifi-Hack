#!/bin/bash

# Autor: Luan Santos
# Empresa: DNSecury - Desenvolvimento e Soluções em segurança cibernética.
# Descrição: Automação dos processos de pentest wireless.
# Versão: 0.1
# Licença: MIT Licence
#
# Contato: luanpsantos@outlook.com.br
# 
# Help:
#    # chmod +x wifihack.sh
#    
#    # ./wifihack.sh
#
#    Após executar o script, sega as instruções no programa.
#    Não faça nenhuma alteração no código fonte ou não mova nenhum arquivo.
#    essas ações pode comprometer o funcionamento da aplicação.



logo(){
    clear
    echo
    echo -e "\033[01;36m======================================================================================================================"
    echo -e " wifi                   wifi wifi  wifiwifiwi wifi               wifi  wifi        wifiwi         wifiwif  wifi  wifi  "
    echo -e "  wifi      wifi       wifi        wifi                          wifi  wifi      wifi  wifi      wifi      wifi wifi   "
    echo -e "   wifi   wifi wifi   wifi   wifi  wifiwifi   wifi   wifi wifi   wifiwiwifi     wifi    wifi    wifi       wifiwi      " 
    echo -e "    wifi  wifi wifi  wifi    wifi  wifi       wifi   wifi wifi   wifiwiwifi    wifiwifiwiwifi   wifi       wifi wifi   "
    echo -e "     wifi wifi wifi wifi     wifi  wifi       wifi               wifi  wifi   wifi        wifi   wifi      wifi  wifi  "
    echo -e "       wifi      wifi        wifi  wifi       wifi               wifi  wifi  wifi          wifi   wifiwif  wifi   wifi "
    echo -e "=======================================================================================================================\033[00;37m"
    echo -e "                          \033[1;3;33mDNSecury - Development and solutions in cyber security.\033[0;37m                                    "
    echo -e "\033[01;31m=======================================================================================================================\033[00;37m"

}


function dependencias() {
    echo
	PROGRAMA=( "aircrack-ng" "gnome-terminal" "figlet" "crunch" "cupp" "cut" "grep" "wash" "bully")
	for prog in "${PROGRAMA[@]}";do
        echo -ne "\033[00;32m               ----------------| $prog for dependencies "
		if ! hash "$prog" 2>/dev/null;then
			echo -e "\033[00;31m<<<Not installed!>>>\033[00;37m"
		else
			echo -e "\033[00;32m<<<Installed!>>>\033[00;37m"
		fi
		sleep 1
		
    done
        
    for prog_inst in "${PROGRAMA[@]}";do
        if ! hash "$prog_inst" 2>/dev/null;then
            echo -e "\n\033[00;32mTrying to install dependencies...\033[00m"
            gnome-terminal --geometry=60x20 --hide-menubar --window -x bash -c "apt-get update && sleep 3 && apt-get install $prog_inst && exit "
            sleep 0.5
        else
            sleep 0.5
            continue
        fi
    done

}

logo
echo -ne "\n\n\033[01;32m=======================================================================================================================
        \n [1] Configuring the Network Card.\n [2] Start with monitoring.\n [3] Initiate the package injection process.\n [4] Start the password processing process.\n [5] Dos attack on wireless networks. \n [6] Check Requirements.\n\n=======================================================================================================================
        \033[01;37m\n\n\033[01;34mEnter the option:\033[00;37m ";read opcao


case $opcao in
    
    1) 
	readonly MONITOR="lib/monitor.sh"
	chmod +x $MONITOR;
	gnome-terminal --geometry=76x27 --hide-menubar --window -x bash -c "./$MONITOR; exec $SHELL"&>/dev/null;
	source wifihack.sh
    ;;
    
    2) 
	readonly MONITORAMENTO="lib/monitoramento.sh"
	chmod +x $MONITORAMENTO;
	gnome-terminal --geometry=76x27 --hide-menubar --window -x bash -c "./$MONITORAMENTO; exec $SHELL" &>/dev/null;
	source wifihack.sh
    ;;
    
    3) 
	readonly INJECTON_PAC="lib/injection.sh"
	chmod +x $INJECTON_PAC;
	gnome-terminal --geometry=76x27 --hide-menubar --window -x bash -c "./$INJECTON_PAC; exec $SHELL" &>/dev/null;
	source wifihack.sh
    ;;
    
    4) 
	readonly CRACKER="lib/cracker.sh"
	chmod +x $CRACKER;
	gnome-terminal --geometry=76x27 --hide-menubar --window -x bash -c "./$CRACKER; exec $SHELL" &>/dev/null;
	source wifihack.sh
    ;;
    
    5) 
    readonly DOS="lib/dos.sh"
    chmod +x $DOS
    gnome-terminal --geometry=76x27 --hide-menubar --window -x bash -c "./$DOS; exec $SHELL " &>/dev/null;
    source wifihack.sh
    ;;

    6)
    logo
    dependencias
    source wifihack.sh
    ;;

    *) 
	source wifihack.sh
    ;;

esac
