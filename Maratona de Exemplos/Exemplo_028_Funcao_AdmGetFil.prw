/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/05/funcao-admgetfil-para-abrir-uma-tela-de-selecao-de-filiais-maratona-advpl-e-tl-028/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe028
Exemplo de função que abre a seleção de filiais
@type Function
@author Atilio
@since 26/11/2022
@obs Função AdmGetFil
    Parâmetros
        + Define se será todas as filiais
        + Somente filiais da empresa logada
        + Define se as filiais levarão em conta o compartilhamento da tabela
        + Somente filiais da unidade de negócio logada
        + Define se irá exibir um help caso nenhuma filial seja selecionada
        + Define se irá exibir a tela para seleção
        + Define o tipo de busca das filiais se é tudo compartilhado conforme o parâmetro cAlias
    Retorno
        + Array com filiais selecionadas

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe028()
    Local aArea  := FWGetArea()
    Local aSelec := {}

    //Busca as filiais para selecionar
    aSelec := AdmGetFil()

    //Mostra a mensagem
    FWAlertInfo("Quantas filiais selecionadas: " + cValToChar(Len(aSelec)), "Filiais")

    FWRestArea(aArea)
Return
