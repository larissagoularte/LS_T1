#!/bin/bash

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Comercio de automoveis usados"
TITLE="Menu"
MENU="Escolha uma das seguintes opções:"

OPTIONS=(1 "Compra"
         2 "Venda"
         3 "Atualizar preço de restauro"
         4 "Alterar dados"
         5 "Visualizar"
         6 "Gestão de Base de Dados"
         7 "Relatórios"
         0 "Sair"
         )

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1) 
            compra
            ;;
            2) 
            venda
            ;;
            3) clear
            restauro
            ;;
            4) clear
            alt_dados
            ;;
            5) clear
            visualizar
            ;;
        6) clear
            gestao
            ;;
        7) clear
            relatorios
            ;;
        0) echo "Saindo..."
            sleep 1
            exit
        ;;

        *) echo "Opção inválida."
            sleep 1
            clear
            
            
    esac
done
}
compra(){
    dialog --msgbox 'Aqui vai a compra ' 5 40  
}
venda(){
    dialog --msgbox 'Aqui vai a venda ' 5 40
}