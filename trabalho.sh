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