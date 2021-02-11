/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/03/12/integracao-do-protheus-com-webcam/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*------------------------------------------------------------------------------------------------------*
 | P.E.:  MA030BUT                                                                                      |
 | Autor: Daniel Atilio                                                                                 |
 | Data:  26/05/2016                                                                                    |
 | Desc:  Adiciona opções no Ações Relacionadas no Cadastro de Clientes                                 |
 | Links: http://tdn.totvs.com/pages/releaseview.action?pageId=6784246                                  |
 *------------------------------------------------------------------------------------------------------*/

User Function MA030BUT()
	Local aArea  := GetArea()
	Local aBotao := {}
	
	//Adicionando o botão no Ações Relacionadas
	AADD(aBotao, {"NOTE", {|| u_zTstWeb()}, "* WebCam"})

	RestArea(aArea)
Return aBotao

/*/{Protheus.doc} zTstWeb
Função desenvolvida para testar a utilização da rotina de WebCam atualizando a imagem no cadastro (Cliente)
@type function
@author Atilio
@since 26/05/2016
@version 1.0
/*/

User Function zTstWeb()
	Local aArea       := GetArea()
	Local cNomeImg    := "cliente_"+M->A1_COD
	Local cNomeFim    := ""
	Local aRet        := {}
	Local oRepository
	Local oDlg
	Local lPut
	Local nTamanImg   := TamSX3('A1_BITMAP')[01]
	Local nAtual      := 0
	Local oObjeto
	Local oPai        := GetWndDefault()
	
	//Chama a rotina para gerar a imagem da WebCam
	aRet := u_zPegaWeb(cNomeImg)
	
	//Se a rotina foi confirmada
	If aRet[1]
		DEFINE MSDIALOG oDlg TITLE "Atualizando imagem do cliente" FROM 000, 000  TO 080, 100 PIXEL
			//Criando o repositório de imagens
			@ 000,000 REPOSITORY oRepository SIZE 0,0 OF oDlg
			
			//Pegando a imagem
			cNomeFim := Upper(AllTrim(aRet[2]))
			cNomeFim := SubStr(cNomeFim, RAt("\", cNomeFim)+1, Len(cNomeFim))
			cNomeFim := StrTran(cNomeFim, ".BMP", "")
			cNomeFim := SubStr(cNomeFim, 1, nTamanImg)
			
			//Se existir a imagem no repositório, exclui
			If oRepository:ExistBmp(cNomeFim)
				oRepository:DeleteBmp(cNomeFim)
			EndIf
			
			//Insere a imagem no repositório
			lPut := .T.
			oRepository:InsertBmp(aRet[2], cNomeFim, @lPut)
			
			//Se deu certo a inserção
			If lPut
				M->A1_BITMAP := cNomeFim
				
				//Percorre todos os campos da Enchoice
				For nAtual := 1 to Len( oPai:aControls )
					//Se não for do tipo objeto, pula
					If ValType(oPai:aControls[nAtual]) != 'O'
						Loop
					Endif
					
					//Pega o objeto
					oObjeto := oPai:aControls[nAtual]
					
					//Se for do tipo Imagem, atualiza a imagem
					If oObjeto:ClassName() == 'FWIMAGEFIELD'
						//Primeiro, é setado qualquer imagem, apenas para forçar o refresh, pois a imagem da webcam terá o mesmo nome
						oObjeto:oImagem:cBMPFile := "ok.png"
						oObjeto:Refresh()
						
						//Agora é setado a imagem
						oObjeto:oImagem:cBMPFile := aRet[2]
						oObjeto:Refresh()
					Endif
				Next
				
				//Atualiza a Enchoice
				GetDRefresh()
			EndIf
			
		ACTIVATE MSDIALOG oDlg CENTERED ON INIT (oDlg:End())
	EndIf
	
	RestArea(aArea)
Return