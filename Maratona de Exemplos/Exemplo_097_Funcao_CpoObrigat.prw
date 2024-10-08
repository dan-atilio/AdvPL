/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/13/validando-se-um-campo-e-obrigatorio-com-a-funcao-cpoobrigat-maratona-advpl-e-tl-097/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe097
Verifica se um campo � obrigat�rio no Protheus
@type Function
@author Atilio
@since 11/12/2022
@obs 
    Fun��o CpoObrigat
    Par�metros
        + Nome do campo
    Retorno
        + .T. se o campo for obrigat�rio ou .F. se n�o

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe097()
    Local aArea     := FWGetArea()
    Local cCampo    := "B1_DESC"

    //Testa se o campo � obrigat�rio
    If CpoObrigat(cCampo)
        FWAlertSuccess("O campo � obrigat�rio", "Teste CpoObrigat")
    Else
        FWAlertError("O campo n�o � obrigat�rio", "Teste CpoObrigat")
    EndIf

    FWRestArea(aArea)
Return
