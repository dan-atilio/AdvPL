/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/05/buscando-informacoes-de-funcoes-com-a-getfuncarray-maratona-advpl-e-tl-275/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe274
Retorna o nome do ambiente (apo / environment) que esta rodando o sistema
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/tec/GetEnvServer
@obs 

    Função GetEnvServer
    Parâmetros
        Não possui parâmetros
    Retorno
        + cRet     , Caractere      , Nome do Environment
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe274()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""

    //Busca a informação e exibe
    cMensagem := "O nome do ambiente que esta rodando o sistema é: " + GetEnvServer()
    FWAlertInfo(cMensagem, "Teste GetEnvServer")

    FWRestArea(aArea)
Return
