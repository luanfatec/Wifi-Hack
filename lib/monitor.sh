#!/bin/bash

clear

logo()
{
	clear
	echo -e "=========================================================================="
	echo -e "                                  MONITOR                              "
	echo -e "=========================================================================="
	echo -e "\033[01;31m==========================================================================\033[00m"
}

# Opções.
logo
echo -ne "\n\033[01;32m==========================================================================\n\n [1] Enable monitor mode.\n [2] Disable monitor mode.\n [3] Display the status of the Interface.\n [4] Check if there is no active process that can interfere with\n monitor mode.\n\n==========================================================================\n\n\033[00;34m Enter the option: \033[00;37m";read opcao


# Função para habilitar o modo Monitor.
fun_on_monitor() {
	clear
	logo
	echo -ne "\n\033[00;33mEnter the name of your wireless interface: \033[00;37m";read IFACE
	echo -e "\033[00;37m"
	airmon-ng start $IFACE
	sleep 3
	echo -e "\n\033[00;32m<<< All ready! >>>\n\033[00;37m"
	sleep 2
	clear
	source lib/monitor.sh
}

# Função para desabilitar o modo Monitor.
fun_off_monitor() {
	clear
	logo
	echo -ne "\n\033[00;33mEnter the name of your interface in monitor mode <wlan0mon>: \033[00;37m";read IFACE
	echo -e "\033[00;37m"
	airmon-ng stop $IFACE
	sleep 3
	echo -e "\n\033[00;32m<<< All ready! >>>\n\033[00;37m"
	sleep 2
	clear
	source lib/monitor.sh
}

# Função para checar em que estado se encontra a interface.
fun_status() {
	clear
	logo
	echo -ne "\n\033[00;33mEnter the name of your wireless interface: \033[00;37m";read IFACE
	clear
	logo
	echo -e "\033[00;37m"
	echo -e "\n\033[00;32mDisplaying $IFACE interface status...\033[00;37m\n"
	sleep 3
	echo
	iwconfig $IFACE
	sleep 5
	clear
	source lib/monitor.sh
}

# Função que irá checar se há processos que possam prejudicar as configurações da placa de rede.
fun_check_proc() {
        clear
		logo
        echo -e "\n\033[00;33mStarting Checking...\033[00;37m\n"
        sleep 3
        var=$(airmon-ng check)
        if test -z "$var";then
                echo -e "\033[00;33mIt's all correct, just start the monitor mode.\033[00;37m"
                sleep 3
                clear
                source lib/monitor.sh
                
        else
                echo -e "found processes:\n$(airmon-ng check)"
                echo -ne "\n\033[00;32mYou want to terminate the active processes(y/n)? \033[00;37m";read ny
                
                if [ "$ny" = "y" -o "$ny" = "Y" ];then
                    echo -e "\n\033[00;33mClosing active processes...\033[00;37m"
                    sleep 3
                    airmon-ng check kill
                    echo -e "\n\033[00;33mProcesses closed!\n\n\033[00;31mBack to the menu...\033[00;37m"
                    sleep 4
                    clear
                    source lib/monitor.sh
                    
                    
                elif [ "$ny" = "n" -o "$ny" = "N" ];then
                    echo -e "\n\033[00;31mBack to the menu...\033[00;37m"
                    sleep 2
                    clear
                    source lib/monitor.sh
                    
                else
                    echo -e "\n\033[00;31mNo answer was according to the question!\n\nBack to the menu...\033[00;37m"
                    sleep 4
                    clear
                    source lib/monitor.sh
                fi
        fi

}

case $opcao in
	
	1) fun_on_monitor ;;
	
	2) fun_off_monitor ;;
	
	3) fun_status ;;
	
	4) fun_check_proc ;;
	
	*) clear
	source lib/monitor.sh
	;;
esac

