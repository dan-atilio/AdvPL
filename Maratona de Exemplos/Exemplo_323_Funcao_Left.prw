/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/29/pegando-o-comeco-de-uma-string-com-a-funcao-left-maratona-advpl-e-tl-323/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe323
Pega o começo de um texto até determinada posição
@type Function
@author Atilio
@since 11/03/2023
@see https://tdn.totvs.com/display/tec/Left
@obs 
    Função Left
    Parâmetros
        + cText        , Caractere , Texto que será analisado
        + nCount       , Numérico  , Indica o número de caracteres
    Retorno
        + cRet         , Caractere , Retorna o texto até aquela determinada posição

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe323()
    Local aArea     := FWGetArea()
    Local cNome     := "Daniel"
    Local cAbreviad := ""

    //Pega só os 3 primeiros caracteres do texto
    cAbreviad := Left(cNome, 3)

    //Mostra o resultado
    FWAlertInfo("O nome '" + cNome + "', somente os 3 primeiros caracteres fica como '" + cAbreviad + "'", "Teste Left")

    FWRestArea(aArea)
Return
