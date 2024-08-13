/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/23/validando-se-um-registro-esta-travado-com-islocked-maratona-advpl-e-tl-311/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zExe310
Valida se um endereço de email é válido
@type  Function
@author Atilio
@since 23/02/2023
@obs 

    Função IsEmail
    Parâmetros
        Recebe o endereço de email
    Retorno
        Retorna .T. se conseguiu validar o endereço de eMail ou .F. se possui algum caractere inválido ou inconsistência

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe310()
	Local aArea      := FWGetArea()
    Local cMensagem  := ""
    
    //Valida um email comum
    cEmail := "contato@atiliosistemas.com"
    If IsEmail(cEmail)
        cMensagem := "O e-Mail '" + cEmail + "' é válido!"
    Else
        cMensagem := "Não foi possível validar o e-Mail '" + cEmail + "'!"
    EndIf
    FWAlertInfo(cMensagem, "Teste 1 IsEmail")


    //Valida um email com erros (espaço e dois arrobas)
    cEmail := "con t@ato@atiliosistemas.com"
    If IsEmail(cEmail)
        cMensagem := "O e-Mail '" + cEmail + "' é válido!"
    Else
        cMensagem := "Não foi possível validar o e-Mail '" + cEmail + "'!"
    EndIf
    FWAlertInfo(cMensagem, "Teste 2 IsEmail")

    FWRestArea(aArea)
Return
