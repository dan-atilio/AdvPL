//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zCriaPar
Função para criação de parâmetros (SX6)
@type function
@author Atilio
@since 12/11/2015
@version 1.0
	@param aPars, Array, Array com os parâmetros do sistema
	@example
	u_zCriaPar(aParametros)
	@see http://terminaldeinformacao.com
	@obs Abaixo a estrutura do array:
		[01] - Parâmetro (ex.: "MV_X_TST")
		[02] - Tipo (ex.: "C")
		[03] - Descrição (ex.: "Parâmetro Teste")
		[04] - Conteúdo (ex.: "123;456;789")
/*/

User Function zCriaPar(aPars)
	Local nAtual		:= 0
	Local aArea		:= GetArea()
	Local aAreaX6		:= SX6->(GetArea())
	Default aPars		:= {}
	
	DbSelectArea("SX6")
	SX6->(DbGoTop())
	
	//Percorrendo os parâmetros e gerando os registros
	For nAtual := 1 To Len(aPars)
		//Se não conseguir posicionar no parâmetro cria
		If !(SX6->(DbSeek(xFilial("SX6")+aPars[nAtual][1])))
			RecLock("SX6",.T.)
				//Geral
				X6_VAR		:=	aPars[nAtual][1]
				X6_TIPO	:=	aPars[nAtual][2]
				X6_PROPRI	:=	"U"
				//Descrição
				X6_DESCRIC	:=	aPars[nAtual][3]
				X6_DSCSPA	:=	aPars[nAtual][3]
				X6_DSCENG	:=	aPars[nAtual][3]
				//Conteúdo
				X6_CONTEUD	:=	aPars[nAtual][4]
				X6_CONTSPA	:=	aPars[nAtual][4]
				X6_CONTENG	:=	aPars[nAtual][4]
			SX6->(MsUnlock())
		EndIf
	Next
	
	RestArea(aAreaX6)
	RestArea(aArea)
Return