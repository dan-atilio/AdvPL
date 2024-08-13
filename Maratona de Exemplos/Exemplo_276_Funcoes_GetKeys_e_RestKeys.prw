/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/06/buscando-informacoes-da-ultima-query-executada-com-a-getlastquery-maratona-advpl-e-tl-277/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe276
Faz um backup das teclas de atalho em memória e depois retorna
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/tec/GetFuncArray
@obs 

    Função GetKeys
    Parâmetros
        Não tem parâmetros
    Retorno
        Retorna o backup das teclas de atalho do F1 ao F12

    Função RestKeys
    Parâmetros
        Recebe um array com o backup realizado
    Retorno
        Não tem retorno
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe276()
    Local aArea    := FWGetArea()
    Local aAtalhos := {}

    //Busca os atalhos em memória
    aAtalhos := GetKeys()

    FWAlertInfo("Suas customizações...", "Teste de GetKeys e RestKeys")

    //Retorna os atalhos
    RestKeys(aAtalhos)

    FWRestArea(aArea)
Return


/*/{Protheus.doc} User Function nomeFunction
Ponto de entrada para adicionar opções no menu do cadastro de produtos
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=370617549
/*/

User Function MTA010MNU()
    Local aArea := GetArea()
    
    //Adicionando uma função no menu principal
    aAdd(aRotina, {"* Testar Atalhos", "u_zExe276()", 0, 2, 0, NIL})
    
    RestArea(aArea)
Return
