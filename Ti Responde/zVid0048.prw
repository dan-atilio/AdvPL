/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/03/20/preencher-o-acols-de-uma-tela-padrao-ti-responde-048/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function MA103BUT
Ponto de Entrada para adicionar uma opção dentro do outras ações do Documento de Entrada
@type  Function
@author Atilio
@since 26/07/2021
@see https://tdn.totvs.com/pages/releaseview.action?pageId=102269141
/*/

User Function MA103BUT()
	Local aArea   := FWGetArea()
	Local aAreaF1 := SF1->(FWGetArea())
	Local aAreaD1 := SD1->(FWGetArea())
	Local aBotao  := {}
	
	aAdd( aBotao, { "BUDGETY"  , { || u_zVid0048()  } , "* Alt. Alíquota IPI" } )

	FWRestArea(aAreaD1)
	FWRestArea(aAreaF1)
	FWRestArea(aArea)
Return aBotao

/*/{Protheus.doc} User Function zVid0048
Função que altera a alíquota do IPI de todas as linhas, conforme digitado numa tela de parâmetro
@type  Function
@author Atilio
@since 26/07/2021
@version version
/*/

User Function zVid0048()
	Local aArea    := GetArea()
	Local nBkp     := n
    Local cCampo   := "D1_IPI"
	Local nPosAliq := GDFieldPos(cCampo)
	Local nAliqNov := 0
	Local cVldSis  := GetSX3Cache(cCampo, "X3_VALID")
	Local cVldUsr  := GetSX3Cache(cCampo, "X3_VLDUSER")
	Local aPergs   := {}
	Local nAtual   := 0
	Local lValidou := .T.
	
	//Adiciona os parâmetros que serão exibidos
	aAdd(aPergs, {1, "Aliq. ICMS",  nAliqNov,  PesqPict("SD1", cCampo), "Positivo()", "", ".T.", 80,  .T.})
	
	//Se a pergunta for confirmada
	If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
		nAliqNov := MV_PAR01
	
		//Percorre todas as linhas da grid
		For nAtual := 1 To Len(aCols)
			lValidou := .T.

			//Altera a linha posicionada na memória
			n := nAtual

			//Altera o ReadVar da Memória
			__ReadVar  := "M->" + cCampo
			M->D1_IPI := nAliqNov

			//Chama a validação do sistema
			If ! Empty(cVldSis)
				lValidou := &(cVldSis)
			EndIf

			//Chama a validação de usuário
			If ! Empty(cVldUsr) .And. lValidou
				lValidou := &(cVldUsr)
			EndIf

			//Se deu certo as validações
			If lValidou
				//Altera a informação de alíquota direto no aCols
				aCols[n][nPosAliq] := nAliqNov

				//Chama gatilho caso exista
				If ExistTrigger(cCampo)
					RunTrigger( ;
						2,;           //nTipo (1=Enchoice; 2=GetDados; 3=F3)
						n,;           //Linha atual da Grid quando for tipo 2
						Nil,;         //Não utilizado
						,;            //Objeto quando for tipo 1
						cCampo;       //Campo que dispara o gatilho
					)
				EndIf
			EndIf
		Next
	EndIf

	n := nBkp
	GetDRefresh()
	RestArea(aArea)	
Return
