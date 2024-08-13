/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/06/quebrando-um-texto-para-um-array-conforme-delimitacao-qbtexto-maratona-advpl-e-tl-398/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe399
Mostra uma mensagem no console.log do AppServer
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/display/tec/QOut
@obs 

    Função QOut
    Parâmetros
        + cText     , Caractere      , Mensagem a ser exibida
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe399()
    Local aArea     := FWGetArea()
    Local cFrase    := "A aranha arranha a rã. A rã arranha a aranha. Nem a aranha arranha a rã. Nem a rã arranha a aranha."
    
    //Exibe 3 mensagens no console
    QOut("> Hoje é "+ dToC(Date()))
    QOut("> Estou no exemplo 399")
    QOut("> A frase é: " + cFrase)

    FWRestArea(aArea)
Return
