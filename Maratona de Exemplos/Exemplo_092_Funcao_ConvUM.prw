/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/08/convertendo-entre-duas-unidades-de-medidas-com-a-funcao-convum-maratona-advpl-e-tl-092/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe092
Exemplo para converter uma quantidade entre as unidades de medidas do produto
@type Function
@author Atilio
@since 11/12/2022
@obs 
    Função ConvUm
    Parâmetros
        + Informa o código do produto
        + Quantidade da primeira unidade de medida
        + Quantidade da segunda unidade de medida
        + Define qual unidade de medida será convertida (1= para a primeira unidade; 2= para a segunda unidade)
    Retorno
        + Retorna a quantidade convertida


    Para utilizar essa rotina é necessário cadastrar os campos (e na direita o que preenchemos):
    + B1_COD     = aqui iremos usar um cadastro de uma caneta com código E0001
    + B1_UM      = será UN (unitário)
    + B1_SEGUM   = será CX (caixa)
    + B1_CONV    = 6.00
    + B1_TIPCONV = Divisor

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe092()
    Local aArea      := FWGetArea()
    Local cProduto   := "E0001"
    Local nConversao := 0

    //Buscando a conversão de 10 pacotes de caneta (segunda unidade de medida), quantas canetas que dão
    nConversao := ConvUm(cProduto, 0, 10, 1)
    FWAlertInfo("Para 10 caixas, serão necessárias " + cValToChar(nConversao) + " canetas", "Teste ConvUm (de segUm para priUm)")

    nConversao := ConvUm(cProduto, 12, 0, 2)
    FWAlertInfo("Para 12 canetas, serão necessárias " + cValToChar(nConversao) + " caixas", "Teste ConvUm (de priUm para segUm)")

    FWRestArea(aArea)
Return
