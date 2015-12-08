//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zDebug
Função de teste para Debug / Depurar programas via TDS
@type function
@author Atilio
@since 06/12/2015
@version 1.0
	@example
	u_zDebug()
/*/

User Function zDebug()
	Local aArea := GetArea()
	Local aProds := {}
	Local nSequen := 0
	
	//Selecionando a tabela de produtos e posicionando no topo
	DbSelectArea("SB1")
	SB1->(DbSetOrder(1)) //Filial + Código
	SB1->(DbGoTop())
	//TODO fazer rotina X
	//Enquanto não for fim do arquivo
	While ! SB1->(EoF())
		aAdd(aProds,{	SB1->B1_COD,;
						SB1->B1_DESC,;
						SB1->B1_TIPO})
	
		nSequen++
		SB1->(DbSkip())
	EndDo
	
	Alert(nSequen)
	RestArea(aArea)
Return