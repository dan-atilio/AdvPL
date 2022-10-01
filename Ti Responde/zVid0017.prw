/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/08/15/como-percorrer-uma-grid-em-mvc-ti-responde-017/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function OMSA010
P.E. Tabela de Preço de Produtos
@author Atilio
@since 08/02/2022
@version 1.0
@type function
@obs Por se tratar de um p.e. em MVC, salve o nome do 
     arquivo diferente, por exemplo, OMSA010_pe.prw 
     *-----------------------------------------------*
     A documentacao de como fazer o p.e. esta disponivel em https://tdn.totvs.com/pages/releaseview.action?pageId=208345968 
/*/

User Function OMSA010()
	Local aArea := GetArea()
	Local aParam := PARAMIXB 
	Local xRet := .T.
	Local oObj := Nil
	Local cIdPonto := ""
	Local cIdModel := ""
	//Variáveis usadas na tratativa de percorrer a grid
	Local nLinha     := 0
	Local aAreaDA1   := {}
    Local aSaveLines := {}
	Local nAlterados := 0
	Local oModelPad  := Nil
	Local oModelGrid := Nil
	Local cCodTab    := ""
    Local cMensagem  := ""
	
	//Se tiver parametros
	If aParam != Nil
		
		//Pega informacoes dos parametros
		oObj := aParam[1]
		cIdPonto := aParam[2]
		cIdModel := aParam[3]
		
		//Validação ao clicar no Botão Confirmar
		If cIdPonto == "MODELPOS" 
			xRet := .T.

			//Define as variáveis que serão usadas
			aAreaDA1   := DA1->(FWGetArea())
            aSaveLines := FWSaveRows()
			nAlterados := 0

			//Pegando os modelos de dados
			oModelPad  := FWModelActive()
			oModelGrid := oModelPad:GetModel('DA1DETAIL')
			cCodTab    := oModelPad:GetValue("DA0MASTER", "DA0_CODTAB")

			DbSelectArea("DA1")
			DA1->(DbSetOrder(3)) //DA1_FILIAL + DA1_CODTAB + DA1_ITEM
			
			//Percorrendo a grid com os itens
			For nLinha := 1 To oModelGrid:Length()

				//Posicionando na linha atual
				oModelGrid:GoLine(nLinha)
				
				//Se a linha tiver deletada, irá armazenar a data e o usuário de alteração
				If oModelGRID:IsDeleted()
					/* ... */

				//Senão, se não for inserção
				ElseIf ! oModelGRID:IsInserted()
					
					//Posiciona na tabela DA1
					DA1->(DbSeek(FWxFilial('DA1') + cCodTab + oModelGrid:GetValue("DA1_ITEM") ))

                    //Se o campo de preço estiver diferente
                    If DA1->DA1_PRCVEN != oModelGrid:GetValue("DA1_PRCVEN")
                        nAlterados++
                    EndIf
				EndIf
			Next

            //Se houve alteração de linhas
            If nAlterados != 0
                cMensagem := "Das [" + cValToChar(oModelGrid:Length()) + "] linhas, foram alterados [" + cValToChar(nAlterados) + "] registros!"
                FWAlertInfo(cMensagem, "Atenção")
            EndIf

            FWRestRows(aSaveLines)
			FWRestArea(aAreaDA1)
		EndIf
		
	EndIf
	
	RestArea(aArea)
Return xRet
