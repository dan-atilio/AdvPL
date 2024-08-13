/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/19/pegando-o-fim-de-uma-string-atraves-da-funcao-right-maratona-advpl-e-tl-425/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe425
Pega o fim de um texto até determinada posição
@type Function
@author Atilio
@since 11/03/2023
@see https://tdn.totvs.com/display/tec/Right
@obs 
    Função Right
    Parâmetros
        + cText        , Caractere , Texto que será analisado
        + nCount       , Numérico  , Indica o número de caracteres
    Retorno
        + cRet         , Caractere , Retorna o texto até aquela determinada posição

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe425()
    Local aArea     := FWGetArea()
    Local cNome     := "Daniel"
    Local cAbreviad := ""

    //Pega só os 3 últimos caracteres do texto
    cAbreviad := Right(cNome, 3)

    //Mostra o resultado
    FWAlertInfo("O nome '" + cNome + "', somente os 3 últimos caracteres fica como '" + cAbreviad + "'", "Teste Right")

    FWRestArea(aArea)
Return
