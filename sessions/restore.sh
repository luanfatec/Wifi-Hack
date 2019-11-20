#!/bin/bash

logo() {
        clear
        echo -e "=========================================================================="
        echo -e "                           RESTORE SESSION           "
        echo -e "=========================================================================="
        echo -e "\033[01;31m==========================================================================\033[00m"
}

# Função restaurar uma sessão.
fun_restore_session() 
{
        logo
        echo -ne "\n\033[00;33mEnter the name of the session that needs to be restored: \033[00;37m";read rest_session
        echo
        aircrack-ng --restore-session sessions/$rest_session.session
        echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL + C if no, wait to return to the initial screen.\033[00;37m"
        sleep 15
        clear
        source lib/cracker.sh
}

fun_restore_session
