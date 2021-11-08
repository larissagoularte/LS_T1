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
	dialog --yesno 'Quer adicionar outra compra?' 0 0

		if [ $? = 0 ]; then
		    compra
		else
			menuPrincipal
		fi

	
}

function atualizaRestauro(){
	custoRest=$(dialog --stdout --inputbox 'Novo preço total de restauro' 0 0)
	#deve procurar pela ?matricula?, e depois substituir o valor
	dialog --title "Restauro" --msgbox 'Custo de restauro atualizado com sucesso!' 0 0 
	menuPrincipal
}

function visualizar(){

	
	
	opcaoVisualizar=$(dialog             \
		--stdout                         \
		--title 'Relatórios'         	 \
		--menu 'Escoha uma opção: '      \
		0 0 0                            \
		1 'Matricula'                    \
		2 'Marca'                        \
		3 'Modelo'                       \
		4 'Ano'                          \
		5 'Tipo'                         \
		0 'Sair para o menu Principal')

	

	case $opcaoVisualizar in
		
		0) menuPrincipal ;;
		#ordenar por matricula
		1) visualizarMatricula;;
		#ordenar por marca
		2)  visualizarMarca;;
		#ordenar por modelo
		3) visualizarModelo 
		;;
		#ordenar por ano
		4) #awk -F ':' '{ print $4 }' basedados.txt 
		;;
		#ordenar por tipo
		5) #awk -F ':' '{ print $5 }' basedados.txt 
		;;
	esac
	
	#cp basedados.txt /Backups/
	
	
	
	
}
#FUNCOES DA FUNCAO VISUALIZAR
		function visualizarMatricula(){
			exw=$(awk -F ':' '{ print $1 }' basedados.txt)
			dialog --title "Relatório de Matriculas" --msgbox "$exw" 0 0
			visualizar
		}
		function visualizarMarca(){
			exm=$(awk -F ':' '{ print $2 }' basedados.txt)
			dialog --title "Relatório de Marcas" --msgbox "$exm" 0 0 
		}
		function visualizarModelo(){
			exmo=$(awk -F ':' '{ print $3 }' basedados.txt)
			dialog --title "Relatório de Modelo" --msgbox "$exmo" 0 0 
		}
function relatorios(){
	opcaoRelatorios=$(dialog             \
		--stdout                         \
		--title 'Relatórios'         	 \
		--menu 'Escoha uma opção: '      \
		0 0 0                            \
		1 'Listar Veículos Vendidos'     \
		2 'Listar Veículos em Stock'     \
		3 'Número de Veículos em Stock'  \
		4 'Número de Veículos vendidos'  \
		5 'Veiculo mais antigo em Stock' \
		6 'Total Lucro'                  \
		0 'Sair para o menu Principal')

	case $opcaoRelatorios in
		0) menuPrincipal ;;
		1)  ;;
		2)  ;;
		3)  ;;
		4)  ;;
		5)  ;;
		6)  ;;
	esac
}

function gestaoBaseDados(){
	opcaoRelatorios=$(dialog             \
		--stdout                         \
		--title 'Relatórios'         	 \
		--menu 'Escoha uma opção: '      \
		0 0 0                            \
		1 'Backup-Criar uma cópia de segurança' \
		2 'Restaurar uma cópia de segurança'    \
		3 'Apagar uma cópia de segurança'       \
		0 'Sair para o menu Principal')

	case $opcaoRelatorios in
		0) menuPrincipal ;;
		1)  ;;
		2)  ;;
		3)  ;;
	esac
}
menuPrincipal
