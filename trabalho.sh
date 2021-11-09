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
	

	echo "$matricula:$marca:$modelo:$ano:$preco:$custoRest" >> basedados.txt
	echo "$matricula:$tipo" >> tiposAutomoveis.txt

	dialog --yesno 'Quer adicionar outra compra?' 0 0

		if [ $? = 0 ]; then
		    compra
		else
			menuPrincipal
		fi

	
}

function atualizaRestauro(){
	pesqmat=$(dialog --stdout --inputbox 'Introduza a Matricula do veículo a restaurar' 0 0)
	
	custoRest=$(dialog --stdout --inputbox 'Novo preço total de restauro' 0 0)
	#deve procurar pela ?matricula?, e depois substituir o valor
	dialog --title "Restauro" --msgbox 'Custo de restauro atualizado para"+$custoRest+"com sucesso!' 0 0 
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
		3) visualizarModelo;;
		#ordenar por ano
		4) visualizarAno;;
		#ordenar por tipo
		5) visualizarTipo;; 
		
	esac
	
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
					visualizar
				}
				function visualizarModelo(){
					exmo=$(awk -F ':' '{ print $3 }' basedados.txt)
					dialog --title "Relatório de Modelo" --msgbox "$exmo" 0 0 
					visualizar
				}
				function visualizarAno(){
					exa=$(awk -F ':' '{ print $4 }' basedados.txt)
					dialog --title "Relatório do Ano" --msgbox "$exa" 0 0 
					visualizar
				}
				function visualizarTipo(){
					ext=$(awk -F ':' '{ print $5 }' basedados.txt)
					dialog --title "Relatório de Tipo" --msgbox "$ext" 0 0 
					visualizar
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
	opacaoBD=$(dialog             \
		--stdout                         \
		--title 'Relatórios'         	 \
		--menu 'Escoha uma opção: '      \
		0 0 0                            \
		1 'Backup-Criar uma cópia de segurança' \
		2 'Restaurar uma cópia de segurança'    \
		3 'Apagar uma cópia de segurança'       \
		0 'Sair para o menu Principal')

	case $opacaoBD in
		0) menuPrincipal ;;
		1) copia;;
		2)  ;;
		3)  ;;
	esac
}
#FUNCÕES DA FUNCÃO GESTAO BASE DE DADOS INACABADO
		function copia(){
			cs=$(cp basedados.txt Backups)
			dialog --title "Backup" --msgbox "Copia de Segurança efetuada com sucesso!" 0 0 
			gestaoBaseDados
		}

		function apagarCopia(){
			ac=$(rm Backups/basedados.txt)
			dialog --title "Backup" --msgbox "Copia de Segurança apagada com sucesso!" 0 0 
			gestaoBaseDados
		}



menuPrincipal
