/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/14/validando-se-um-campo-esta-em-uso-pelo-sistema-com-a-funcao-cpousado-maratona-advpl-e-tl-098/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe098
Verifica se um campo esta marcado como usado no Protheus
@type Function
@author Atilio
@since 11/12/2022
@obs 
    Função CpoUsado
    Parâmetros
        + Nome do campo
    Retorno
        + .T. se o campo estiver sendo usado ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe098()
    Local aArea     := FWGetArea()
    Local cCampo    := "B1_SEGUM"

    //Testa se o campo é usado
    If CpoUsado(cCampo)
        FWAlertSuccess("O campo é usado", "Teste CpoUsado")
    Else
        FWAlertError("O campo não é usado", "Teste CpoUsado")
    EndIf

    FWRestArea(aArea)
Return
