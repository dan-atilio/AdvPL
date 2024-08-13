/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/04/convertendo-string-para-numerico-com-getdtoval-e-val-maratona-advpl-e-tl-272/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe273
Retorna o IP e porta do AppServer que esta rodando a Thread
@type  Function
@author Atilio
@since 21/02/2023
@obs 

    Função GetEndPointIP
    Parâmetros
        Não possui parâmetros
    Retorno
        Retorna o IP e Porta da conexão
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe273()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""

    //Busca a informação e exibe
    cMensagem := "Os dados de conexão são: " + GetEndPointIP()
    FWAlertInfo(cMensagem, "Teste GetEndPointIP")

    FWRestArea(aArea)
Return
