/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/11/removendo-aspas-de-uma-string-com-a-removeasp-maratona-advpl-e-tl-409/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe408
Faz a separação de DDI, DDD e número do telefone
@type Function
@author Atilio
@since 28/03/2023
@obs 

    Função RemDddTel
    Parâmetros
        Recebe o telefone no formato DDI+DDD+Numero
    Retorno
        Retorna um Array com as posições separadas

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe408()
    Local aArea     := FWGetArea()
    Local cNumero   := ""
    Local aDados    := {}
    
    //Separa a string
    cNumero   := "5514999998888"
    aDados    := RemDddTel(cNumero)
    cMensagem := "Numero: " + aDados[1] + CRLF
    cMensagem += "DDD: "    + aDados[2] + CRLF
    cMensagem += "DDI: "    + aDados[3] + CRLF
    FWAlertInfo(cMensagem, "Teste RemDddTel")

    FWRestArea(aArea)
Return
