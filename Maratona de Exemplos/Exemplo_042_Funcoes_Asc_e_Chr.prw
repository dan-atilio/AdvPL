/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/19/buscando-um-caractere-ou-um-codigo-ascii-com-as-funcoes-chr-e-asc-maratona-advpl-e-tl-042/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe042
Exemplo de função que busca o código ASCII de um caractere assim como informa o caractere de um código ASCII
@type Function
@author Atilio
@since 29/11/2022
@see https://tdn.totvs.com/display/tec/Asc e https://tdn.totvs.com/display/tec/Chr
@obs 
    Função Asc
    Parâmetros
        + cString   , Caractere , Indica o caractere que será buscado o código ASCII
    Retorno
        + nRet      , Numérico  , Retorna o número do caractere da tabela ASCII (0 à 255)

    Função Chr
    Parâmetros
        + nCodigo   , Numérico  , Indica o número do caractere na tabela ASCII (0 à 255)
    Retorno
        + cRet      , Caractere , Retorna o caractere respectivo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe042()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""
    Local cEnter     := ""
    Local cLetra     := ""
    Local nCaractere := ""

    //O Enter, será os códigos ASCII 13 + 10, é o mesmo que utilizar a constante CRLF
    cEnter := Chr(13) + Chr(10)

    //Busca o código ASCII da letra D
    cLetra     := "D"
    nCaractere := Asc(cLetra)

    //Monta a mensagem
    cMensagem := "Testes realizados com Chr e Asc" + cEnter
    cMensagem += "A letra '" + cLetra + "' tem o código '" + cValToChar(nCaractere) + "' na tabela ASCII" + CRLF
    cMensagem += "Mais um teste apenas quebrando a linha"

    //Mostra o resultado
    FWAlertInfo(cMensagem, "Resultado")

    FWRestArea(aArea)
Return
