/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/09/buscando-o-numero-do-recno-de-um-registro-com-a-recno-maratona-advpl-e-tl-405/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe405
Busca o registro atual posicionado na tabela
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/display/tec/Recno
@obs 
    Função RecNo
    Parâmetros
        Função não tem parâmetros
    Retorno
        + nRec       , Numérico      , Retorna o número do registro atual da tabela

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe405()
    Local aArea     := FWGetArea()
    Local nRecNo    := 0

    //Busca o registro posicionado e mostra
    nRecno := SB1->(RecNo())
    FWAlertInfo("O registro posicionado é " + cValToChar(nRecNo), "Teste RecNo")

    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function nomeFunction
Ponto de entrada para adicionar opções no menu do cadastro de produtos
@type  Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=370617549
/*/

User Function MTA010MNU()
    Local aArea := FWGetArea()
    
    //Adicionando uma função no menu principal
    aAdd(aRotina, {"* Testar RecNo", "u_zExe405()", 0, 2, 0, NIL})
    
    FWRestArea(aArea)
Return
