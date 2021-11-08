#!/bin/bash

menuPrincipal(){
	opcaoPrincipal=$(dialog              \
		--stdout                         \
		--title 'Menu Principal'         \
		--menu 'Escoha uma opção: '      \
		0 0 0                            \
		1 'Compra'                       \
		2 'Venda'                        \
		3 'Atualizar preço de restauro'  \
		4 'Alterar dados'                \
		5 'Visualizar automóveis'        \
		6 'Gestão de base de dados'      \
		7 'Relatórios'                   \
		0 'Sair do programa')

	case $opcaoPrincipal in
		0) sair ;;
		1) compra ;;
		2) venda ;;
		3) atualizaRestauro ;;
		4) alteraDados ;;
		5) visualizar ;;
		6) gestaoBaseDados ;;
		7) relatorios ;;
	esac
}

function compra() {
	matricula=$(dialog --stdout --inputbox 'Matricula' 0 0)
	marca=$(dialog --stdout --inputbox 'Marca' 0 0)
	modelo=$(dialog --stdout --inputbox 'modelo' 0 0)
	ano=$(dialog --stdout --inputbox 'Ano' 0 0)
	tipo=$(dialog --stdout --inputbox 'Tipo' 0 0)
	preco=$(dialog --stdout --inputbox 'Preço' 0 0)
	custoRest=$(dialog --stdout --inputbox 'Custo de Restauro' 0 0)
	
	echo "$matricula:$marca:$modelo:$ano:$tipo:$preco:$custoRest" >> basedados.txt
	dialog --yesno 'Quer ver as horas?' 0 0

	if [ $? = 0 ]; then
	        echo "Agora são: $( date )"
	else
	        echo 'Ok, não vou mostrar as horas.'
	fi
	menuPrincipal
}

function atualizaRestauro(){
	custoRest=$(dialog --stdout --inputbox 'Novo preço total de restauro' 0 0)

}

function visualizar(){
	dialog --textbox basedados.txt 20 80
	menuPrincipal
}
menuPrincipal
