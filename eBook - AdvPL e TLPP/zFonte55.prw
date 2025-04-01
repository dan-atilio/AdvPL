/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "Totvs.ch"
#Include "RESTFul.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} WSRESTFUL zFonte55
Criação de Produtos
@author Atilio
@since 13/03/2025
@version 1.0
@type wsrestful
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

WSRESTFUL zFonte55 DESCRIPTION 'Criação de Produtos'
    //Métodos
    WSMETHOD POST   NEW    DESCRIPTION 'Inclusão de registro'          WSSYNTAX '/zFonte55/new'                               PATH 'new'           PRODUCES APPLICATION_JSON
END WSRESTFUL

/*/{Protheus.doc} WSMETHOD POST NEW
Cria um novo registro na tabela
@author Atilio
@since 13/03/2025
@version 1.0
@type method
@obs Codigo gerado automaticamente pelo Autumn Code Maker

    Abaixo um exemplo do JSON que deverá vir no body
    * 1: Para campos do tipo Numérico, informe o valor sem usar as aspas
    * 2: Para campos do tipo Data, informe uma string no padrão 'YYYY-MM-DD'

    {
        "cod": "conteudo",
        "desc": "conteudo",
        "tipo": "conteudo",
        "um": "conteudo"
    }

@see http://autumncodemaker.com
/*/

WSMETHOD POST NEW WSRECEIVE WSSERVICE zFonte55
    Local lRet              := .T.
    Local aDados            := {}
    Local jJson             := Nil
    Local cJson             := Self:GetContent()
    Local cError            := ''
    Local nLinha            := 0
    Local cDirLog           := '\x_logs\'
    Local cArqLog           := ''
    Local cErrorLog         := ''
    Local aLogAuto          := {}
    Local nCampo            := 0
    Local jResponse         := JsonObject():New()
    Local cAliasWS          := 'SB1'
    Private lMsErroAuto     := .F.
    Private lMsHelpAuto     := .T.
    Private lAutoErrNoFile  := .T.
 
    //Se não existir a pasta de logs, cria
    IF ! ExistDir(cDirLog)
        MakeDir(cDirLog)
    EndIF    

    //Definindo o conteúdo como JSON, e pegando o content e dando um parse para ver se a estrutura está ok
    Self:SetContentType('application/json')
    jJson  := JsonObject():New()
    cError := jJson:FromJson(cJson)
 
    //Se tiver algum erro no Parse, encerra a execução
    IF ! Empty(cError)
        //SetRestFault(500, 'Falha ao obter JSON') //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
        Self:setStatus(500) 
        jResponse['errorId']  := 'NEW004'
        jResponse['error']    := 'Parse do JSON'
        jResponse['solution'] := 'Erro ao fazer o Parse do JSON'

    Else
		DbSelectArea(cAliasWS)
       
		//Adiciona os dados do ExecAuto
		aAdd(aDados, {'B1_COD',   jJson:GetJsonObject('cod'),   Nil})
		aAdd(aDados, {'B1_DESC',   jJson:GetJsonObject('desc'),   Nil})
		aAdd(aDados, {'B1_TIPO',   jJson:GetJsonObject('tipo'),   Nil})
		aAdd(aDados, {'B1_UM',   jJson:GetJsonObject('um'),   Nil})
		
		//Percorre os dados do execauto
		For nCampo := 1 To Len(aDados)
			//Se o campo for data, retira os hifens e faz a conversão
			If GetSX3Cache(aDados[nCampo][1], 'X3_TIPO') == 'D'
				aDados[nCampo][2] := StrTran(aDados[nCampo][2], '-', '')
				aDados[nCampo][2] := sToD(aDados[nCampo][2])
			EndIf
		Next

		//Chama a inclusão automática
		MsExecAuto({|x, y| MATA010(x, y)}, aDados, 3)

		//Se houve erro, gera um arquivo de log dentro do diretório da protheus data
		If lMsErroAuto
			//Monta o texto do Error Log que será salvo
			cErrorLog   := ''
			aLogAuto    := GetAutoGrLog()
			For nLinha := 1 To Len(aLogAuto)
				cErrorLog += aLogAuto[nLinha] + CRLF
			Next nLinha

			//Grava o arquivo de log
			cArqLog := 'zFonte55_New_' + dToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.log'
			MemoWrite(cDirLog + cArqLog, cErrorLog)

			//Define o retorno para o WebService
			//SetRestFault(500, cErrorLog) //caso queira usar esse comando, você não poderá usar outros retornos, como os abaixo
           Self:setStatus(500) 
			jResponse['errorId']  := 'NEW005'
			jResponse['error']    := 'Erro na inclusão do registro'
			jResponse['solution'] := 'Nao foi possivel incluir o registro, foi gerado um arquivo de log em ' + cDirLog + cArqLog + ' '
			lRet := .F.

		//Senão, define o retorno
		Else
			jResponse['note']     := 'Registro incluido com sucesso'
		EndIf

    EndIf

    //Define o retorno
    Self:SetResponse(EncodeUTF8(jResponse:toJSON()))
Return lRet
