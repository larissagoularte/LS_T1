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
#Compra
function compra() {
	#fazer aqui um if para  a verificação
	matricula=$(dialog --stdout --title "Compra de veículo" --nocancel --inputbox 'Matricula' 0 0)
	marca=$(dialog --stdout --title "Compra de veículo" --nocancel --inputbox 'Marca' 0 0)
	modelo=$(dialog --stdout --title "Compra de veículo" --nocancel --inputbox 'Modelo' 0 0)
	ano=$(dialog --stdout --title "Compra de veículo" --nocancel --inputbox 'Ano' 0 0)
	tipo=$(dialog --stdout --title "Compra de veículo" --nocancel --inputbox 'Tipo' 0 0)
	preco=$(dialog --stdout --title "Compra de veículo" --nocancel --inputbox 'Preço' 0 0)
	dataCp=$(dialog --stdout --title "Compra de veículo" --nocancel --inputbox 'Data de Compra:' 0 0)
	custoRest=$(dialog --stdout --title "Compra de veículo" --nocancel --inputbox 'Custo de Restauro' 0 0)
	
	if [[ $matricula && $marca && $modelo && $ano && $tipo && $preco && $dataCp && $custoRest ]]; then
		echo "$matricula:$marca:$modelo:$ano:$preco:$custoRest" >> basedados.txt
		echo "$matricula:$tipo" >> tiposAutomoveis.txt
	else
		dialog --stdout --title "Aviso" --nocancel --msgbox "É necessário o preenchimento de todos os campos para a adicionar uma compra!" 0 0
		dialog --yesno 'Deseja continuar?' 0 0
		if [ $? = 0 ]; then
		    compra
		else
			menuPrincipal
		fi
	fi	
}
#Venda
function venda(){

	bdVendas=bdVendas.txt
	basedados=basedados.txt
	show=$(cat basedados.txt)
	dialog --title "Venda de veículo"  --msgbox "$show" 0 0
	mVenda=$(dialog --stdout --title "Venda de veículo" --nocancel --inputbox 'Introuza a Matricula do veículo a vender:' 0 0)
	pVenda=$(dialog --stdout --title "Venda de veículo" --nocancel --inputbox 'Introuza o preco de venda do veículo:' 0 0)
	dVenda=$(dialog --stdout --title "Venda de veículo" --nocancel --inputbox 'Introduza a data de venda: ' 0 0)
	
	if [[ $mVenda && $pVenda && dVenda ]]; then
		var=$(grep $mVenda $basedados)
		echo "$var:$pVenda:$dVenda" >> $bdVendas
		grep -v $mVenda $basedados > tmp.txt
		rm $basedados
		mv temp.txt $basedados
		dialog --title "Venda de veículos" --msgbox 'Venda efetuada com sucesso!' 0 0 
	else
		dialog --stdout --title "Aviso" --nocancel --msgbox "É necessário o preenchimento de todos os campos para a adicionar uma compra!" 0 0
		dialog --yesno 'Deseja continuar?' 0 0
		if [ $? = 0 ]; then
		    venda
		else
			menuPrincipal
		fi

	fi
	menuPrincipal
}

#Atualiza o preço de restauro
function atualizaRestauro(){
	basedados=basedados.txt
	show=$(cat basedados.txt)
	dialog --title "Venda de veículo"  --msgbox "$show" 0 0
	pesqmat=$(dialog --stdout --title 'Atualizar preço de restauro' --nocancel --inputbox 'Introduza a Matricula do veículo:' 0 0)
	custoRest=$(dialog --stdout --title 'Atualizar preço de restauro' --nocancel --inputbox 'Novo preço total de restauro:' 0 0)
	if [[ $pesqmat && $custoRest ]]; then
		marca=$(grep $pesqmat $basedados | cut -f 2 -d ':')
		modelo=$(grep $pesqmat $basedados | cut -f 3 -d ':')
		ano=$(grep $pesqmat $basedados | cut -f 4 -d ':')
		preco=$(grep $pesqmat $basedados | cut -f 5 -d ':')
		grep -v $pesqmat $basedados > tmp.txt
		echo "$pesqmat:$marca:$modelo:$ano:$preco:$custoRest" >> tmp.txt
		rm $basedados
		mv tmp.txt $basedados
		dialog --title "Restauro" --msgbox 'Custo de restauro atualizado para '$custoRest' com sucesso!' 0 0 
	else 
		dialog --stdout --title "Aviso" --nocancel --msgbox "É necessário o preenchimento de todos os campos para a atualização do restauro!" 0 0
		dialog --yesno 'Deseja continuar?' 0 0
		if [ $? = 0 ]; then
		    atualizaRestauro
		else
			menuPrincipal
		fi
	fi
	
	menuPrincipal
}

function alteraDados(){
	opcaoAlterar=$(dialog                                   \
				   --stdout                                 \
				   --title 'Alteração de dados'             \
				   --menu 'Escolha o que quer alterar: '    \
				   0 0 0                                    \
				   1 'Matricula'                            \
				   2 'Marca'                                \
				   3 'Modelo'                               \
				   4 'Ano'                                  \
				   5 'Tipo'                                 \
				   6 'Preço'                                \
				   0 'Sair para o menu Principal')

	case $opcaoAlterar in
		0) menuPrincipal ;;
		1) alterarMatricula ;;
		2) alterarMarca ;;
		3) alterarModelo ;;
		4) alterarAno ;;
		5) alterarTipo ;;
		6) alterarPreco ;;
	esac
}

function alterarMatricula(){
	#é necessário fazer a verificação
	basedados=basedados.txt

	pedeMatricula=$(dialog --stdout --title 'Alteração de dados' --nocancel --inputbox 'Introduza a matrícula que quer alterar: ' 0 0)
	alteraMatricula=$(dialog --stdout --title 'Alteração de dados' --nocancel --inputbox 'Para que matrícula quer alterar: ' 0 0)
	if [[ $pedeMatricula && $alteraMatricula ]]; then
		marca=$(grep $pedeMatricula $basedados | cut -f 2 -d ':')
		modelo=$(grep $pedeMatricula $basedados | cut -f 3 -d ':')
		ano=$(grep $pedeMatricula $basedados | cut -f 4 -d ':')
		preco=$(grep $pedeMatricula $basedados | cut -f 5 -d ':')
		custoRest=$(grep $pedeMatricula $basedados | cut -f 6 -d ':')

		grep -v $pedeMatricula $basedados > tmp.txt
		echo "$alteraMatricula:$marca:$modelo:$ano:$preco:$custoRest" >> tmp.txt

		rm $basedados
		mv tmp.txt $basedados

		dialog --title "Modificação de matrícula" --msgbox 'Matrícula alterada para '$alteraMatricula' com sucesso!' 0 0 
	else
		dialog --stdout --title "Aviso" --nocancel --msgbox "É necessário o preenchimento de todos os campos para a alteração da matricula!" 0 0
		dialog --yesno 'Deseja continuar?' 0 0
		if [ $? = 0 ]; then
		    alterarMatricula
		else
			alteraDados
		fi
	fi
	

	menuPrincipal
}

function alterarMarca(){
	#é necessário fazer a verificação
	basedados=basedados.txt

	pedeMarca=$(dialog --stdout --title 'Alteração de dados' --nocancel --inputbox 'Introduza a matrícula da marca que quer alterar: ' 0 0)
	alteraMarca=$(dialog --stdout --title 'Alteração de dados' --nocancel --inputbox 'Para que marca quer alterar?: ' 0 0)
	if [[ $pedeMarca && $alteraMarca ]]; then
		matricula=$(grep $pedeMarca $basedados | cut -f 1 -d ':')
		modelo=$(grep $pedeMarca $basedados | cut -f 3 -d ':')
		ano=$(grep $pedeMarca $basedados | cut -f 4 -d ':')
		preco=$(grep $pedeMarca $basedados | cut -f 5 -d ':')
		custoRest=$(grep $pedeMarca $basedados | cut -f 6 -d ':')

		grep -v $pedeMarca $basedados > tmp.txt
		echo "$matricula:$alteraMarca:$modelo:$ano:$preco:$custoRest" >> tmp.txt

		rm $basedados
		mv tmp.txt $basedados

		dialog --title "Modificação de marca" --msgbox 'Marca alterada para '$alteraMarca' com sucesso!' 0 0 
	else
		dialog --stdout --title "Aviso" --nocancel --msgbox "É necessário o preenchimento de todos os campos para a alteração da marca!" 0 0
		dialog --yesno 'Deseja continuar?' 0 0
		if [ $? = 0 ]; then
		    alterarMarca
		else
			alteraDados
		fi
	fi
	

	menuPrincipal
}

function alterarModelo(){
	#é necessário fazer a verificação
	basedados=basedados.txt

	pedeModelo=$(dialog --stdout --title 'Alteração de dados' --nocancel --inputbox 'Introduza a matrícula do modelo que quer alterar: ' 0 0)
	alteraModelo=$(dialog --stdout --title 'Alteração de dados' --nocancel --inputbox 'Para que modelo quer alterar?: ' 0 0)
	if [[ $pedeModelo && $alteraModelo ]]; then
		matricula=$(grep $pedeModelo $basedados | cut -f 1 -d ':')
		marca=$(grep $pedeModelo $basedados | cut -f 2 -d ':')
		ano=$(grep $pedeModelo $basedados | cut -f 4 -d ':')
		preco=$(grep $pedeModelo $basedados | cut -f 5 -d ':')
		custoRest=$(grep $pedeModelo $basedados | cut -f 6 -d ':')

		grep -v $pedeModelo $basedados > tmp.txt
		echo "$matricula:$marca:$alteraModelo:$ano:$preco:$custoRest" >> tmp.txt

		rm $basedados
		mv tmp.txt $basedados

		dialog --title "Modificação de modelo" --msgbox 'Modelo alterado para '$alteraModelo' com sucesso!' 0 0 
		else
			dialog --stdout --title "Aviso" --nocancel --msgbox "É necessário o preenchimento de todos os campos para a alteração da modelo!" 0 0
			dialog --yesno 'Deseja continuar?' 0 0
			if [ $? = 0 ]; then
			    alterarModelo
			else
				alteraDados
			fi
	fi
	
	menuPrincipal

}

function alterarAno(){
	#é necessário fazer a verificação
	basedados=basedados.txt

	pedeAno=$(dialog --stdout --nocancel --title 'Alteração de dados' --inputbox 'Introduza a matrícula da ano que quer alterar: ' 0 0)
	alteraAno=$(dialog --stdout --nocancel --title 'Alteração de dados' --inputbox 'Para que ano quer alterar?: ' 0 0)
	
	if [[ $pedeAno && $alteraAno ]]; then
		matricula=$(grep $pedeAno $basedados | cut -f 1 -d ':')
		marca=$(grep $pedeAno $basedados | cut -f 2 -d ':')
		modelo=$(grep $pedeAno $basedados | cut -f 3 -d ':')
		preco=$(grep $pedeAno $basedados | cut -f 5 -d ':')
		custoRest=$(grep $pedeAno $basedados | cut -f 6 -d ':')

		grep -v $pedeAno $basedados > tmp.txt
		echo "$matricula:$marca:$modelo:$alteraAno:$preco:$custoRest" >> tmp.txt

		rm $basedados
		mv tmp.txt $basedados

		dialog --title "Modificação de ano" --msgbox 'Ano alterado para '$alteraAno' com sucesso!' 0 0 
		else
			dialog --stdout --title "Aviso" --nocancel --msgbox "É necessário o preenchimento de todos os campos para a alteração do ano!" 0 0
			dialog --yesno 'Deseja continuar?' 0 0
			if [ $? = 0 ]; then
			    alterarAno
			else
				alteraDados
			fi
	fi
	
	menuPrincipal

}

function alterarTipo(){
	#é necessário fazer a verificação
	tipoAutomoveis=tiposAutomoveis.txt

	pedeTipo=$(dialog --stdout --nocancel --title 'Alteração de dados' --inputbox 'Introduza a matrícula do tipo que quer alterar: ' 0 0)
	alteraTipo=$(dialog --stdout --nocancel --title 'Alteração de dados' --inputbox 'Para que tipo quer alterar?: ' 0 0)
	
	if [[ $pedeTipo && $alteraTipo ]]; then
		matricula=$(grep $pedeTipo $tipoAutomoveis | cut -f 1 -d ':')
		tipo=$(grep $pedeTipo $tipoAutomoveis | cut -f 2 -d ':')

		grep -v $pedeTipo $tipoAutomoveis > tmp.txt
		echo "$matricula:$alteraTipo" >> tmp.txt

		rm $tipoAutomoveis
		mv tmp.txt $tipoAutomoveis

		dialog --title "Modificação de tipo" --msgbox 'Tipo alterado para '$alteraTipo' com sucesso!' 0 0 
		else
			dialog --stdout --title "Aviso" --nocancel --msgbox "É necessário o preenchimento de todos os campos para a alteração do tipo!" 0 0
			dialog --yesno 'Deseja continuar?' 0 0
			if [ $? = 0 ]; then
			    alterarTipo
			else
				alteraDados
			fi
	fi
	
	menuPrincipal

}

function alterarPreco(){
	
	basedados=basedados.txt

	pedePreco=$(dialog --stdout --title 'Alteração de dados' --nocancel --inputbox 'Introduza a matrícula da preço que quer alterar: ' 0 0)
	alteraPreco=$(dialog --stdout --title 'Alteração de dados' --nocancel --inputbox 'Para que preço quer alterar?: ' 0 0)
	
	if [[ condition ]]; then
		matricula=$(grep $pedePreco $basedados | cut -f 1 -d ':')
		marca=$(grep $pedePreco $basedados | cut -f 2 -d ':')
		modelo=$(grep $pedePreco $basedados | cut -f 3 -d ':')
		ano=$(grep $pedePreco $basedados | cut -f 4 -d ':')
		custoRest=$(grep $pedePreco $basedados | cut -f 6 -d ':')

		grep -v $pedePreco $basedados > tmp.txt
		echo "$matricula:$marca:$modelo:$ano:$alteraPreco:$custoRest" >> tmp.txt

		rm $basedados
		mv tmp.txt $basedados

		dialog --title "Modificação de preço" --msgbox 'Preço alterado para '$alteraPreco' com sucesso!' 0 0 
		else
			dialog --stdout --title "Aviso" --nocancel --msgbox "É necessário o preenchimento de todos os campos para a alteração do preço!" 0 0
			dialog --yesno 'Deseja continuar?' 0 0
			if [ $? = 0 ]; then
			    alterarPreco
			else
				alteraDados
			fi
	fi
	
	menuPrincipal

}
#esta função permite visualizar ordenando por categoria
function visualizar(){
	opcaoVisualizar=$(dialog             \
		--stdout                         \
		--title 'Visualizar'         	 \
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
#funções pertencentes a visualizar()
function visualizarMatricula(){
	exw=$(sort -n -t ":" -k 1 basedados.txt)
	dialog --title "Organizado por Matrículas" --msgbox "$exw" 0 0
	visualizar
}
function visualizarMarca(){
	exm=$(sort -t ":" -k 2 basedados.txt)
	dialog --title "Organizado por Marcas" --msgbox "$exm" 0 0 
	visualizar
}
function visualizarModelo(){
	exmo=$(sort -t ":" -k 3 basedados.txt)
	dialog --title "Organizado por Modelo" --msgbox "$exmo" 0 0 
	visualizar
}
function visualizarAno(){
	exa=$(sort -n -t ":" -k 4 basedados.txt)
	dialog --title "Organizado por Ano" --msgbox "$exa" 0 0 
	visualizar
}

#Falta ir buscar o resto das informações do automóvel. Neste momento só mostra o que está no ficheiro tipoAutomoveis, ou seja, matrícula e tipo
function visualizarTipo(){
	ext=$(sort -t ":" -k 2 tiposAutomoveis.txt)
	dialog --title "Organizado por Tipo" --msgbox "$ext" 0 0 
	visualizar
}

#função para mostrar relatorios
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
		0) menuPrincipal;;
		1) veiculosVendidos;;
		2) veiculoStock;;
		3) numVStock;;
		4) numVVendidos;;
		5) maisAntigoS;;
		6)  ;;
	esac
}

#Relatório de veículos em stock
function veiculosVendidos(){
	vV=$(cat bdVendas.txt)
	dialog --title "Veículos vendidos" --msgbox "$vV" 0 0
	relatorios
}
function veiculoStock(){
	vS=$(cat basedados.txt)
	dialog --title "Stock de veículos" --msgbox "$vS" 0 0
	relatorios
}

function numVStock(){
	numeroVS=$(grep -c ^ basedados.txt)
	dialog --title "Relatório"  --msgbox "O número de veiculos em stock é de: ""$numeroVS" 0 0
	relatorios
}
function numVVendidos(){
	numeroVv=$(grep -c ^ bdVendas.txt)
	dialog --title "Relatório"  --msgbox "O número de veiculos em stock é de: ""$numeroVv" 0 0
	relatorios
}
#Veiculo mais antigo em Stock
function maisAntigoS(){
	maisAnt=$(head -n 1 basedados.txt)
	dialog --title "Relatório" --msgbox "O veiculo mais antigo em stock é: ""$maisAnt" 0 0 
}

function gestaoBaseDados(){
	opacaoBD=$(dialog             \
		--stdout                         \
		--title 'Gestão de Base de dados'         	 \
		--menu 'Escoha uma opção: '      \
		0 0 0                            \
		1 'Backup-Criar uma cópia de segurança' \
		2 'Restaurar uma cópia de segurança'    \
		3 'Apagar uma cópia de segurança'       \
		0 'Sair para o menu Principal')

	case $opacaoBD in
		0) menuPrincipal ;;
		1) copia;;
		2) restauroCopia;;
		3) apagarCopia;;
	esac
}
#FUNCÕES DA FUNCÃO GESTAO BASE DE DADOS 
		function copia(){
			nf=$(date +"%m-%d-%H-%M")
			cs=$(cp basedados.txt Backups/$nf.txt)
			dialog --title "Backup" --msgbox "Copia de Segurança efetuada com sucesso!" 0 0 
			gestaoBaseDados
		}
		#esta função vai apagar copias de segurança
		function apagarCopia(){
			ls Backups/ > output_file.txt
			show=$(cat output_file.txt)
			dialog --title "Backup"  --msgbox "$show" 0 0
			nomeFich=$(dialog --stdout --nocancel --inputbox 'Introduza o nome do ficheiro a restaurar:' 0 0)
			if [[ $nomeFich ]]; then
				while [[ $nomeFich ]]; do
				dialog --yesno 'Tem a certeza que deseja apagar?' 0 0
					if [ $? = 0 ]; then
						apagarDefinitivo
					else
						dialog --title "Aviso" --msgbox 'Não foi apagado nenhuma Cópia de Segurança!' 0 0
						gestaoBaseDados

					fi
				done
			else 
				dialog --title "Aviso" --msgbox 'Não foi apagado nenhuma Cópia de Segurança!' 0 0
				gestaoBaseDados
			fi
		}
		#esta função pertence a apagarCopia()
		function apagarDefinitivo(){
				ac=$(rm Backups/$nomeFich)
				dialog --title "O Backup $nomeFich foi apagado! " --msgbox "$ac" 0 0
				dialog --yesno 'Deseja apagar outra Cópia de Segurança?' 0 0
				if [ $? = 0 ]; then
					apagarCopia
				else
					gestaoBaseDados
				fi
		}

		function restauroCopia(){
			ls Backups/ > output_file.txt
			show=$(cat output_file.txt)
			dialog --title "Backup"  --msgbox "$show" 0 0
			nomeFich=$(dialog --stdout --nocancel --inputbox 'Introduza o nome do ficheiro a restaurar:' 0 0)
			retaurarCopia=$(cp -f  Backups/$nomeFich basedados.txt)
			gestaoBaseDados
		}


menuPrincipal
