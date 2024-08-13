/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/21/criando-uma-lista-com-thashmap-maratona-advpl-e-tl-491/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe491
Cria uma lista onde é possível pesquisar por valores
@type Function
@author Atilio
@since 04/04/2023
@see https://tdn.totvs.com/display/tec/Classe+THashMap
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe491()
    Local aArea       := FWGetArea()
    Local oHash       := ""
    Local cNome       := ""
    Local aListaElem  := ""

    //Instancia em um novo objeto
    oHash := THashMap():New()

    //Adiciona alguns elementos
    oHash:Set("nome",                  "Daniel")
    oHash:Set("gostaDeLer",            .T.)
    oHash:Set("dataDeHoje",            Date())
    oHash:Set("anoQueLancouOTerminal", 2012)

    //Busca o valor de um elemento e exibe em tela
    oHash:Get("nome", cNome)
    FWAlertInfo(cNome, "Teste 1 THashMap")

    //Busca todos os elementos encontrados e coloca em um array e exibe
    oHash:List(aListaElem)
    FWAlertInfo("Linha 3, Coluna 1: " +aListaElem[3][1], "Teste 2 THashMap")
    
    //Encerra o objeto
    oHash:Clean()

    FWRestArea(aArea)
Return

