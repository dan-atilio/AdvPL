/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/26/testar-a-pilha-de-chamadas-com-as-funcoes-atisrotina-e-fwisincallstack-maratona-advpl-e-tl-049/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe049
Exemplo de fun��o que verifica se esta sendo acionada por alguma fun��o da pilha de chamadas
@type Function
@author Atilio
@since 01/12/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=161349910
@obs 
    Fun��o AtIsRotina
    Par�metros
        + Indica o nome da fun��o a ser procurada na pilha de chamadas
    Retorno
        + Retorna .T. se encontrou ou .F. se n�o encontrou

    Fun��o FWIsInCallStack
    Par�metros
        + Indica o nome da fun��o a ser procurada na pilha de chamadas
    Retorno
        + Retorna .T. se encontrou ou .F. se n�o encontrou

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe049()
    Local aArea      := FWGetArea()
    Local cFuncBusca := ""

    //Buscando pela AtIsRotina (s� funciona se tudo tiver mai�sculo)
    cFuncBusca := "U_ZMINIFORM"
    If AtIsRotina(cFuncBusca)
        FWAlertInfo("Foi acionado pela fun��o - " + cFuncBusca, "Exemplo AtIsRotina")
    EndIf

    //Buscando pela FWIsInCallStack (independe se for mai�scula ou min�scula)
    cFuncBusca := "u_zMiniForm"
    If FWIsInCallStack(cFuncBusca)
        FWAlertInfo("Foi acionado pela fun��o - " + cFuncBusca, "Exemplo FWIsInCallStack")
    EndIf

    FWRestArea(aArea)
Return
