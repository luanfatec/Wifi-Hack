#!/bin/bash

clear
logo()
{
        clear
        echo -e "=========================================================================="
        echo -e "                                  CRACKER                         "
        echo -e "=========================================================================="
        echo -e "\033[01;31m=========================================================================="
}

# Opções de execução.
logo
echo -ne "\n\033[01;32m==========================================================================\n\n[1] Check for a handshake in the cap file.\n[2] Start the password wipe process using a dictionary of words.\n[3] Start a PWT attack.\n[4] Create and/or update session files by saving current cracking status every 10 minutes.\n[5] Restore session.\n[6] Use multiple capture files at a time to be broken in just one command.\n[7] Use Multiple Dictionaries in a Single Command to Break the Handshake.\n[8] Start a break without a dictionary.\n\n==========================================================================\033[01;37m\n\n\033[01;34mEnter the option:\033[00m ";read opcao


# Função de verificação de hash no file.
fun_verifica() {
	clear
        logo
	echo -ne "\n\033[00;33mEnter the .cap file that contains the handshake:\033[00m";read arquivo_cap
	echo
	aircrack-ng handshakes/$arquivo_cap
	echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
	sleep 10
	clear
	source lib/cracker.sh
}

# Função responsável por quebrar um dicionário.
fun_crack_dic() {
	clear
        logo
	echo -ne "\n\033[00;33mEnter the .cap file containing the handshake:\033[00m";read arquivo_cap
	echo
	echo -ne "\n\033[00;33mEnter the file containing the word dictionary:\033[00m";read arquivo_dic
        echo	
	aircrack-ng handshakes/$arquivo_cap -w wordlists/$arquivo_dic
	echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
	sleep 15
	clear
	source lib/cracker.sh
}

# Função responsável por fazer o ataque pwt.
fun_ataque_pwt() {
	clear
        logo
	echo -ne "\n\033[00;33mEnter the .cap file that contains the handshake:\033[00m";read arquivo_cap
	echo
	aircrack-ng -z handshakes/$arquivo_cap
	echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
	sleep 15
	clear
	source lib/cracker.sh
}

# Função responsável por recuperar a sessão, para continuar a quebra de hash.
# Lembrando que essa função é específica para apenas a quebra de um arquivo.
fun_session() {
	clear
        logo
	echo -ne "\n\033[00;33mEnter the file containing the word dictionary:\033[00m";read arquivo_dic
	echo
	echo -ne "\n\033[00;33mEnter the .cap file that contains the handshake:\033[00m";read arquivo_cap
	echo
	echo -ne "\n\033[00;33mEnter a title to save the session:\033[00m";read name_session
	echo
	aircrack-ng --new-session sessions/$name_session.session -w wordlists/$arquivo_dic $arquivo_cap
	echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
	sleep 15
	clear
	source lib/cracker.sh
}

# Função responsável por quebrar até cinco arquivos .cap.
fun_varios_cap() {
	clear
        logo
	echo -ne "\n\033[01;33mHow many .cap files will be used?\033[01;32m
	\n\n [1] 1 Archive.\n [2] 2 Archive.\n [3] 3 Archive.\n [4] 4 Archive.\n [5] 5 Archive.\n\n \033[01;34mEnter quantity: \033[00m";read opcao
	clear
        logo
	echo
	
	if test "$opcao" -eq 1;then
                # Arrays de perguntas.
                pergunta=( "#First: ")

                # Loop para circular todas as perguntas do array.
                for i in 0; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                            read -p ${pergunta[$i]} resposta[$i]
                    done
                done
                echo -ne "\n\033[00;33mEnter the name of the word dictionary: \033[00m";read file_pass
                echo
                aircrack-ng handshakes/${resposta[0]} -w wordlists/$file_pass
                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
		clear
		source lib/cracker.sh

	elif test "$opcao" -eq 2;then
                # Arrays de perguntas.
                pergunta=( "#First: " "#Second: ")

                # Loop para circular todas as perguntas do array.
                for i in 0 1; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                            read -p ${pergunta[$i]} resposta[$i]
                    done
                done
                echo -ne "\n\033[00;33mEnter the name of the word dictionary: \033[00m";read file_pass
                echo
                aircrack-ng handshakes/${resposta[0]} handshakes/${resposta[1]} -w wordlists/$file_pass
                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
		clear
		source lib/cracker.sh

	elif test "$opcao" -eq 3;then
                # Arrays de perguntas.
                pergunta=( "#First: " "#Second: " "#Third: ")

                # Loop para circular todas as perguntas do array.
                for i in 0 1 2; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                            read -p ${pergunta[$i]} resposta[$i]
                    done
                done
                echo -ne "\n\033[00;33mEnter the word dictionary name: \033[00m";read file_pass
                echo
                aircrack-ng handshakes/${resposta[0]} handshakes/${resposta[1]} handshakes/${resposta[2]}  -w wordlists/$file_pass
                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
		clear
		source lib/cracker.sh

	elif test "$opcao" -eq 4;then
                # Arrays de perguntas.
                pergunta=( "#First: " "#Second: " "#Third: " "#Bedroom: " )

                # Loop para circular todas as perguntas do array.
                for i in 0 1 2 3; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                            read -p ${pergunta[$i]} resposta[$i]
                    done
                done
                echo -ne "\n\033[00;33mEnter the word dictionary name: \033[00m";read file_pass
                echo
                aircrack-ng handshakes/${resposta[0]} handshakes/${resposta[1]} handshakes/${resposta[2]} handshakes/${resposta[3]}  -w wordlists/$file_pass
                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
		clear
		source lib/cracker.sh

	elif test "$opcao" -eq 5;then
		# Array de perguntas.
		pergunta=( "#First: " "#Second: " "#Third: " "#Bedroom: " "#Fifth: " )

                # Loop para circular todas as perguntas do array.
                for i in 0 1 2 3 4; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
		    do
			    read -p ${pergunta[$i]} resposta[$i]
                    done
	        done
		echo -ne "\n\033[00;33mEnter the word dictionary name: \033[00m";read file_pass
        	echo
        	aircrack-ng handshakes/${resposta[0]} handshakes/${resposta[1]} handshakes/${resposta[2]} handshakes/${resposta[3]} handshakes/${resposta[4]} -w wordlists/$file_pass
		echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
		sleep 15
		source lib/cracker.sh
	else
		clear
		source lib/cracker.sh
	fi

}

# Função responsável por quebrar um arquivo .cap com até cinco wordlists.
fun_varios_dic() {
        clear
        logo
        echo -ne "\n\033[01;33mHow many dictionaries will I need to use?\033[01;32m
        \n\n [1] 1 Dictionary.\n [2] 2 Dictionary.\n [3] 3 Dictionary.\n [4] 4 Dictionary.\n [5] 5 Dictionary.\n\n \033[01;34mEnter Quantity: \033[00m";read opcao
        clear
        logo
	echo

        if test "$opcao" -eq 1;then
                # Arrays de perguntas.
                pergunta=( "#First: ")

                # Loop para circular todas as perguntas do array.
                for i in 0; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                            read -p ${pergunta[$i]} resposta[$i]
                    done
                done
                echo -ne "\n\033[00;33mEnter the name of the file that contains the handshake:: \033[00m";read file_pass
                echo
                aircrack-ng wordlists/${resposta[0]} -w handshakes/$file_pass
                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
                clear
                source lib/cracker.sh

        elif test "$opcao" -eq 2;then
                # Arrays de perguntas.
                pergunta=( "#First: " "#Second: ")

                # Loop para circular todas as perguntas do array.
                for i in 0 1; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                            read -p ${pergunta[$i]} resposta[$i]
                    done
                done
                echo -ne "\n\033[00;33mEnter the name of the file that contains the handshake:: \033[00m";read file_pass
                echo
                aircrack-ng wordlists/${resposta[0]} wordlists/${resposta[1]} -w handshakes/$file_pass
                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
                clear
                source lib/cracker.sh

        elif test "$opcao" -eq 3;then
                # Arrays de perguntas.
                pergunta=( "#First: " "#Second: " "#Third: ")

                # Loop para circular todas as perguntas do array.
                for i in 0 1 2; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                            read -p ${pergunta[$i]} resposta[$i]
                    done
                done
                echo -ne "\n\033[00;33mEnter the name of the file that contains the handshake: \033[00m";read file_pass
                echo
                aircrack-ng wordlists/${resposta[0]} wordlists/${resposta[1]} wordlists/${resposta[2]}  -w handshakes/$file_pass
                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
                clear
                source lib/cracker.sh

        elif test "$opcao" -eq 4;then
                # Arrays de perguntas.
                pergunta=( "#First: " "#Second: " "#Third: " "#Bedroom: " )

                # Loop para circular todas as perguntas do array.
                for i in 0 1 2 3; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                            read -p ${pergunta[$i]} resposta[$i]
                    done
                done
                echo -ne "\n\033[00;33mEnter the name of the file that contains the handshake: \033[00m";read file_pass
                echo
                aircrack-ng wordlists/${resposta[0]} wordlists/${resposta[1]} wordlists/${resposta[2]} wordlists/${resposta[3]}  -w handshakes/$file_pass
                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
                clear
                source lib/cracker.sh

        elif test "$opcao" -eq 5;then
                # Arrays de perguntas.
                pergunta=( "#First: " "#Second: " "#Third: " "#Bedroom: " "#Fifth: " )

                # Loop para circular todas as perguntas do array.
                for i in 0 1 2 3 4; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                            read -p ${pergunta[$i]} resposta[$i]
                    done
                done
                echo -ne "\n\033[00;33mEnter the name of the file that contains the handshake: \033[00m";read file_pass
                echo
                aircrack-ng ../wordlists/${resposta[0]} wordlists/${resposta[1]} wordlists/${resposta[2]} wordlists/${resposta[3]} wordlists/${resposta[4]} -w handshakes/$file_pass
                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
                source lib/cracker.sh
        else
                clear
                source lib/cracker.sh
        fi

}

# Função responsável por quebrar até cinco arquivos .cap sem usar wordlists.
fun_sem_dic(){	
        clear
        logo
        echo -ne "\n\033[01;33mHow many .cap files will be used?\033[01;32m
        \n [1] 1 Archive.\n [2] 2 Archive.\n [3] 3 Archive.\n [4] 4 Archive.\n [5] 5 Archive.\n\n \033[01;34mDigite a quantidade:: \033[00m";read opcao
        echo
        clear
        logo
        echo

        if test "$opcao" -eq 1;then
                # Arrays de perguntas.
                pergunta=( "#First: " )

                # Loop para circular todas as perguntas do array.
                for i in 0; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                        read -p ${pergunta[$i]} resposta[$i]
                    done
                done

                echo -ne "\n\033[00;33mPlease inform ESSID, target network name: \033[00m";read name_essid
                echo -ne "\n\033[00;33mEnter the characters to be used in the process: \033[00m";read caracteres
                echo -ne "\n\033[00;33mEnter the minimum number of characters: \033[00m";read min_caracteres
                echo -ne "\n\033[00;33mEnter the maximum number of characters: \033[00m";read max_caracteres
                echo
                crunch $min_caracteres $max_caracteres $caracteres |aircrack-ng handshakes/${resposta[0]} -w - -e $name_essid

                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
                source lib/cracker.sh
                
        elif test "$opcao" -eq 2;then
                # Arrays de perguntas.
                pergunta=( "#First: " "#Second: " )
                
                # Loop para circular todas as perguntas do array.
                for i in 0 1; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                        read -p ${pergunta[$i]} resposta[$i]
                    done
                done

                echo -ne "\n\033[00;33mPlease inform ESSID, target network name: \033[00m";read name_essid
                echo -ne "\n\033[00;33mEnter the characters to be used in the process: \033[00m";read caracteres
                echo -ne "\n\033[00;33mEnter the minimum number of characters: \033[00m";read min_caracteres
                echo -ne "\n\033[00;33mEnter the maximum number of characters: \033[00m";read max_caracteres
                echo
                crunch $min_caracteres $max_caracteres $caracteres |aircrack-ng handshakes/${resposta[0]} handshakes/${resposta[1]} -w - -e $name_essid

                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
                source lib/cracker.sh

        elif test "$opcao" -eq 3;then
                # Arrays de perguntas.
                pergunta=( "#First: " "#Second: " "#Third: " )

                # Loop para circular todas as perguntas do array.
                for i in 0 1 2; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                        read -p ${pergunta[$i]} resposta[$i]
                    done
                done

                echo -ne "\n\033[00;33mPlease inform ESSID, target network name: \033[00m";read name_essid
                echo -ne "\n\033[00;33mEnter the characters to be used in the process: \033[00m";read caracteres
                echo -ne "\n\033[00;33mEnter the minimum number of characters: \033[00m";read min_caracteres
                echo -ne "\n\033[00;33mEnter the maximum number of characters: \033[00m";read max_caracteres
                echo
                crunch $min_caracteres $max_caracteres $caracteres |aircrack-ng handshakes/${resposta[0]} handshakes/${resposta[1]} handshakes/${resposta[2]} -w - -e $name_essid

                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
                source lib/cracker.sh
                
        elif test "$opcao" -eq 4;then
                # Arrays de perguntas.
                pergunta=( "#First: " "#Second: " "#Third: " "#Bedroom: " )

                # Loop para circular todas as perguntas do array.
                for i in 0 1 2 3; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                        read -p ${pergunta[$i]} resposta[$i]
                    done
                done

                echo -ne "\n\033[00;33mPlease inform ESSID, target network name: \033[00m";read name_essid
                echo -ne "\n\033[00;33mEnter the characters to be used in the process: \033[00m";read caracteres
                echo -ne "\n\033[00;33mEnter the minimum number of characters: \033[00m";read min_caracteres
                echo -ne "\n\033[00;33mEnter the maximum number of characters: \033[00m";read max_caracteres
                echo
                crunch $min_caracteres $max_caracteres $caracteres |aircrack-ng handshakes/${resposta[0]} handshakes/${resposta[1]} handshakes/${resposta[2]} handshakes/${resposta[3]} -w - -e $name_essid

                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
                source lib/cracker.sh
                
        elif test "$opcao" -eq 5;then
                # Arrays de perguntas.  
                pergunta=( "#First: " "#Second: " "#Third: " "#Bedroom: " "#Fifth: " )

                # Loop para circular todas as perguntas do array.
                for i in 0 1 2 3 4; do
                # Mostra a pergunta, verifica se obteve a resposta e se não for vazia, coloca a resposta no array "resposta", se for vazia, pergunta dnovo.
                    while [ -z ${resposta[$i]} ]
                    do
                        read -p ${pergunta[$i]} resposta[$i]
                    done
                done

                echo -ne "\n\033[00;33mPlease inform ESSID, target network name: \033[00m";read name_essid
                echo -ne "\n\033[00;33mEnter the characters to be used in the process: \033[00m";read caracteres
                echo -ne "\n\033[00;33mEnter the minimum number of characters: \033[00m";read min_caracteres
                echo -ne "\n\033[00;33mEnter the maximum number of characters: \033[00m";read max_caracteres
                echo
                crunch $min_caracteres $max_caracteres $caracteres |aircrack-ng handshakes/${resposta[0]} handshakes/${resposta[1]} handshakes/${resposta[2]} handshakes/${resposta[3]} handshakes/${resposta[4]} -w - -e $name_essid

                echo -e "\n\033[00;31mDo you want to keep this screen? If yes press CTRL+C if you do not expect to return to the home screen.\033[00m"
                sleep 15
                source lib/cracker.sh
                
                
        else
            clear
            source lib/cracker.sh
        fi




}



################### <<< Lógica >>> #####################

case $opcao in
        1) fun_verifica
        ;;
        
        2) fun_crack_dic
        ;;

        3) fun_ataque_pwt
        ;;

        4) fun_session
        ;;

        5) source sessions/restore.sh
        ;;

        6) fun_varios_cap
        ;;

        7) fun_varios_dic
        ;;

        8) fun_sem_dic
        ;;

        *) clear
	 source lib/cracker.sh
        ;;
esac