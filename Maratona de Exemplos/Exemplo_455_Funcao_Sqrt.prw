/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/03/monta-um-order-by-conforme-indice-atraves-da-sqlorder-maratona-advpl-e-tl-454/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe455
Retorna o resultado de uma raiz quadrada
@type Function
@author Atilio
@since 31/03/2023
@see https://tdn.totvs.com/display/tec/Sqrt
@obs 

    Função Sqrt
    Parâmetros
        + nRadicand    , Numérico     , Indica o valor que será analisado
    Retorno
        + nRet         , Numérico     , Retorna o resultado da raiz quadrada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe455()
    Local aArea      := FWGetArea()
    Local nValor     := 0
    Local nResultado := 0

    //Monta as informações
    nValor     := 144
    nResultado := Sqrt(nValor)

    //Exibe o resultado
    FWAlertInfo("A raiz quadrada de '" + cValToChar(nValor) + "' é '" + cValToChar(nResultado) + "'!", "Teste Sqrt")

    FWRestArea(aArea)
Return
