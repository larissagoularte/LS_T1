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
	echo "5) Visualizar"
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
read -p "Introduza o preço de compra: " preco

#era suposto chamar a funcao para calcular o preco de venda com o preco introduzido + o preco de restauro introduzido em outra funcao
#not working tho
preco_venda 

echo -n "$matricula:$marca:$modelo:$ano:$tipo:$preco_venda" >> basedados.txt
sort -n basedados.txt > tmp
mv tmp basedados.txt
}

restauro(){

	read -p "Introduza o valor de restauro: " restauro
	echo "O preço de restauro foi atualizado para $restauro."

}

#ISSO NAO TA FUNCIONANDO
preco_venda(){
	preco_venda = $((preco + restauro))

	return
}

visualizar(){
while :
do
echo " ------------------------------------ "
echo "| Visualizar automóveis por critério |"
echo " ------------------------------------ "
echo ""
echo "1) Matricula"
echo "2) Marca"
echo "3) Modelo"
echo "4) Ano"
echo "5) Tipo"
echo "0) Voltar para o menu principal"
echo ""
read -p "Introduza a opção: " opcaoVisualizar

case $opcaoVisualizar in
	1) clear
	echo " ------------ "
	echo "| Matriculas |"
	echo " ------------ "
	echo ""

	awk -F ':' '{ print $1 }' basedados.txt
	;;

	2) clear
	echo " ------- "
	echo "| Marca |"
	echo " ------- "
	echo ""

	awk -F ':' '{ print $2 }' basedados.txt
	;;

	3) clear
	echo " -------- "
	echo "| Modelo |"
	echo " -------- "
	echo ""

	awk -F ':' '{ print $3 }' basedados.txt
	;;

	4) clear
	echo " ----- "
	echo "| Ano |"
	echo " ----- "
	echo ""

	awk -F ':' '{ print $4 }' basedados.txt
	;;

	5) clear
	echo " ------ "
	echo "| Tipo |"
	echo " ------ "
	echo ""

	awk -F ':' '{ print $5 }' basedados.txt
	;;

	0) clear
	menu_principal
	;;

	*) echo "Opção inválida..."
	sleep 1
	clear
	;;
	esac
done
}

alt_dados(){
while :
do
	echo " --------------- "
	echo "| Alterar dados |"
	echo " --------------- "
	echo ""
	echo "1) Matricula"
	echo "2) Marca"
	echo "3) Modelo"
	echo "4) Ano"
	echo "5) Tipo"
	echo "0) Voltar para o menu principal"
	read -p "Introduza o que deseja alterar: " opcaoAlterar
	read -p "Introduza a matrícula do veículo que deseja alterar dados: " matricula_alterar
	case $opcaoAlterar in
	1) clear
	read -p "Introduza a nova matrícula: " nova_matricula
	c=$(grep "$matricula_alterar:" basedados.txt | cut -f 1 -d ':')
	grep "$matricula_alterar:" basedados.txt >> tmp2
	sed -i "s/$c/$nova_matricula/" tmp2
	grep -v "$matricula_alterar:" basedados.txt >> tmp2
	mv tmp2 basedados.txt
	sort -n basedados.txt -o basedados.txt
	;;

	esac
done
}
menu_principal


