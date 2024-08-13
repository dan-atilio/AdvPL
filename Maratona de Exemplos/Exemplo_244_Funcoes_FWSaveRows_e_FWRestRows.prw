/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/19/buscando-todos-usuarios-cadastrados-atraves-da-fwsfallusers-maratona-advpl-e-tl-245/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe244
Armazena a posição na grid da tela e depois volta
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWSaveRows e https://tdn.totvs.com/display/public/framework/FWRestRows
@obs 

    Função FWSaveRows
    Parâmetros
        + oModel         , Objeto          , Modelo de dados em memória
    Retorno
        + aRet           , Array           , Array com as posições que serão recuperadas

    Função FWRestRows
    Parâmetros
        + aIDs           , Array           , Array com as posições
        + oModel         , Objeto          , Modelo de dados
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe244()
    Local aArea := FWGetArea()
    Local aSaveLines := FWSaveRows()
    //Pegando os modelos de dados
    Local oModelPad  := FWModelActive()
    Local oModelGrid := oModelPad:GetModel('DA1DETAIL')

    //Adicionando uma linha
    oModelGrid:AddLine()

    FWRestRows(aSaveLines)
    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function OMSA010
Ponto de Entrada no Cadastro de Tabelas de Preço
@author Daniel Atilio
@since 28/02/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
     *-------------------------------------------------*
     Por se tratar de um p.e. em MVC, salve o nome do 
     arquivo diferente, por exemplo, OMSA010_pe.prw 
     *-----------------------------------------------*
     A documentacao de como fazer o p.e. esta disponivel em https://tdn.totvs.com/pages/releaseview.action?pageId=208345968 

     Associe "FORM" com banco de dados, com ModelDef
     Associe "MODEL" com visualização, com ViewDef
@see http://autumncodemaker.com
/*/

User Function OMSA010()
	Local aArea := FWGetArea()
	Local aParam := PARAMIXB 
	Local xRet := .T.
	Local oObj := Nil
	Local cIdPonto := ""
	Local cIdModel := ""
	
	//Se tiver parametros
	If aParam != Nil
		
		//Pega informacoes dos parametros
		oObj := aParam[1]
		cIdPonto := aParam[2]
		cIdModel := aParam[3]
			
		//Para a inclusao de botoes na ControlBar 
		If cIdPonto == "BUTTONBAR" 
			xRet := {} 
			aAdd(xRet, {"* Salvar e Voltar a Posição",  "", {|| u_zExe244()}, "Salv. Volt. Pos."})
		EndIf
		
	EndIf
	
	FWRestArea(aArea)
Return xRet
