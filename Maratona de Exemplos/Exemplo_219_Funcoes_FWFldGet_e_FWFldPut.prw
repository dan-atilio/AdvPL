/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/06/manipulando-campos-em-mvc-com-fwfldget-e-fwfldput-maratona-advpl-e-tl-219/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe219
Exemplo de função que pega ou atribui um valor em um campo em MVC
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWFldGet e https://tdn.totvs.com/display/public/framework/FWFldPut
@obs 

    Função FWFldGet
    Parâmetros
        + cCampo         , Caractere       , Nome do Campo
        + nLinha         , Numérico        , Número da linha (quando se esta em uma GRID)
        + oModel         , Objeto          , Variável contendo o Modelo de Dados ativo na memória
        + lShowMsg       , Lógico          , .T. se exibe mensagem de erro ao tentar buscar o campo ou .F. se não
    Retorno
        + xRet           , Indefinido      , Conteúdo inserido no campo

    Função FWFldPut
    Parâmetros
        + cCampo         , Caractere       , Nome do Campo
        + xConteudo      , Indefinido      , Conteúdo que será atribuído
        + nLinha         , Numérico        , Número da linha (quando se esta em uma GRID)
        + oModel         , Objeto          , Variável contendo o Modelo de Dados ativo na memória
        + lShowMsg       , Lógico          , .T. se exibe mensagem de erro ao tentar preencher o campo ou .F. se não
        + lLoad          , Lógico          , .T. se força a atribuição de conteúdo no campo ou .F. se não
    Retorno
        + lRet           , Lógico          , .T. se o conteúdo foi atribuído ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe219()
    Local aArea  := FWGetArea()

    //Mostra a pergunta
    If FWAlertYesNo("Deseja utilizar as Funções (clique em Sim) ou deseja utilizar os métodos (clique em Não)?", "Atenção")
        fUsaFuncao()
    Else
        fUsaMetodo()
    EndIf

    FWRestArea(aArea)
Return

Static Function fUsaFuncao()
    Local aPergs    := {}
    Local cDescri   := FWFldGet("DA0_DESCRI")
    
    //Adicionando os parametros que serão digitados
    aAdd(aPergs, {1, "Descrição",  cDescri,  "",     "NaoVazio()", "", ".T.", 80,  .T.})
    
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
        //Atualiza o valor
        cDescri := MV_PAR01
        FwFldPut("DA0_DESCRI", cDescri)
    EndIf
Return

Static Function fUsaMetodo()
    Local aPergs    := {}
    Local oModelPad := FWModelActive()
    Local cDescri   := oModelPad:GetValue("DA0MASTER", "DA0_DESCRI")
    
    //Adicionando os parametros que serão digitados
    aAdd(aPergs, {1, "Descrição",  cDescri,  "",     "NaoVazio()", "", ".T.", 80,  .T.})
    
    If ParamBox(aPergs, "Informe os parâmetros", , , , , , , , , .F., .F.)
        //Atualiza o valor
        cDescri := MV_PAR01
        oModelPad:SetValue("DA0MASTER", "DA0_DESCRI", cDescri)
    EndIf
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
			aAdd(xRet, {"* Atualizar Descrição",        "", {|| u_zExe219()}, "Atu. Descr"})
		EndIf
		
	EndIf
	
	FWRestArea(aArea)
Return xRet
