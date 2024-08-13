/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/23/buscando-relacionamentos-das-tabelas-com-a-fwsx9util-maratona-advpl-e-tl-253/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe253
Classe para buscar informações da SX9 (Relacionamentos)
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/public/framework/FWSX9Util
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe253()
    Local aArea      := FWGetArea()
    Local aRelac     := {}
    Local lTemRelac  := .F.

    //Busca os relacionametnos entre as tabelas CC2 e SC5 (Cidades e Pedidos de venda)
    lTemRelac := FWSX9Util():SearchX9Paths("CC2", "SC5", @aRelac)

    //Se encontrou relacionamentos, mostra a mensagem
    If lTemRelac
        FWAlertInfo("Foi encontrado " + cValToChar(Len(aRelac)) + " relacionamento(s)", "Teste FWSX9Util")
    EndIf

    FWRestArea(aArea)
Return
