/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/10/posicionando-no-final-de-um-alias-com-dbgobottom-maratona-advpl-e-tl-124/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe124
Posiciona no último registro conforme o índice usado
@type Function
@author Atilio
@since 14/12/2022
@see https://tdn.totvs.com/display/tec/DBGoBottom
@obs 

    Função DbGoBottom
    Parâmetros
        Não tem parâmetros
    Retorno
        Não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe124()
    Local aArea      := FWGetArea()

    //Abre o cadastro de produtos, ordenando por descrição
    DbSelectArea("SB1")
    SB1->(DbSetOrder(3)) // B1_FILIAL + B1_DESC + B1_COD

    //Posiciona no final da tabela
    SB1->(DbGoBottom())

    //Mostra o último produto encontrado
    FWAlertInfo("O último produto conforme a descrição é '" + Alltrim(SB1->B1_DESC) + "'", "Teste DbGoBottom")

    FWRestArea(aArea)
Return
