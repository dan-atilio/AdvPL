/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/10/simulando-um-ctrl-c-com-a-funcao-copytoclipboard-maratona-advpl-e-tl-094/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe094
Exemplo de função para colocar uma informação no clipboard do sistema operacional
@type Function
@author Atilio
@since 11/12/2022
@see https://tdn.totvs.com/display/tec/CopytoClipboard
@obs 
    Função CopyToClipBoard
    Parâmetros
        + cTexto        , Caractere    , Texto que será enviado para a área de transferência do S.O.

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe094()
    Local aArea     := FWGetArea()
    Local cTexto    := ""

    //Abre a tabela de produtos, e pega a primeira descrição
    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) // Filial + Código
    cTexto := Alltrim(SB1->B1_DESC)

    //Coloca esse texto na clipboard
    CopyToClipBoard(cTexto)

    FWRestArea(aArea)
Return
