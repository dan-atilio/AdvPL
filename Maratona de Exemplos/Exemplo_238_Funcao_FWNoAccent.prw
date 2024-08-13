/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/16/formatando-e-preparando-uma-query-com-a-fwpreparedstatement-maratona-advpl-e-tl-239/
*/


//Bibliotecas
#Include 'TOTVS.ch'
 
/*/{Protheus.doc} User Function zExe238
Retira acentos de uma string
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FwNoAccent
@obs 
    Função FWNoAccent
    Parâmetros
        + cString       , Caractere         , Texto a ser validado
    Retorno
        Retorna a string sem os acentos

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe238()
	Local aArea     := GetArea()
    Local cFrase    := "A aranha arranha a rã. A rã arranha a aranha. Nem a aranha arranha a rã. Nem a rã arranha a aranha."
    Local cFraseSem := ""
     
    //Retira o acento e mostra a mensagem
    cFraseSem := FWNoAccent(cFrase)
    FWAlertInfo(cFraseSem, "Teste FWNoAccent")
     
    RestArea(aArea)
Return
