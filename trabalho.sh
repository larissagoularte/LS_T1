#!/bin/bash

menu_principal(){
while :
do
	echo " ---------------- "
	echo "| Menu Principal |"
	echo " ---------------- "

	echo "1) Compra"
	echo "2) Venda"
	echo "3) Atualizar preço de restauro"
	echo "4) Alterar dados"
	echo "5) Visualizar automóveis"
	echo "6) Gestão de Base de Dados"
	echo "7) Relatórios"
	echo ""
	echo "0) Sair"
	echo ""
	read -p "Introduza a opção: " opcao

	case $opcao in
		1) clear
		   	compra
			;;
	        2) clear
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

let stock++

read -p "Introduza a matrícula: " matricula
read -p "Introduza  a marca: " marca
read -p "Introduza o modelo: " modelo
read -p "Introdduza o ano: " ano
read -p "Introduza o tipo: " tipo

echo -n "$matricula:$marca:$modelo:$ano:$tipo" >> basedados.txt
sort -n basedados.txt > tmp
mv tmp basedados.txt

}
menu_principal


