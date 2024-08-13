/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/11/posicionando-em-um-registro-de-um-alias-com-dbgoto-maratona-advpl-e-tl-125/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe125
Posiciona em um registro da tabela com o número do recno
@type Function
@author Atilio
@since 14/12/2022
@see https://tdn.totvs.com/display/tec/DBGoTo
@obs 

    Função DbGoTo
    Parâmetros
        + nPos     , Numérico     , Número do Recno
    Retorno
        Não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe125()
    Local aArea      := FWGetArea()
    Local nRecno     := 0

    //Abre o cadastro de produtos
    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) // B1_FILIAL + + B1_COD

    //Busca um Recno para posicionar
    nRecno := Val(FWInputBox("Digite um Recno para posicionar na SB1:"))

    //Se houver recno
    If nRecno != 0

        //Posiciona no registro
        SB1->(DbGoTo(nRecno))

        //Mostra o produto encontrado
        FWAlertInfo("O produto conforme o RecNo fornecido é '" + Alltrim(SB1->B1_DESC) + "'", "Teste DbGoTo")

    EndIf

    FWRestArea(aArea)
Return
