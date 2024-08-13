/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/27/compactando-e-descompactando-arquivos-com-fzip-e-funzip-maratona-advpl-e-tl-260/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe261
Função que abre uma tela para seleção de registros conforme um Array
@type  Function
@author Atilio
@since 21/02/2023
@obs 

    Função F_Opcoes
    Parâmetros
        + Define a variável de retorno
        + Define o texto do título da janela
        + Define o array de linhas da grid
        + Define os códigos das linhas da grid
        + Mantido por compatibilidade
        + Mantido por compatibilidade
        + Define se será a seleção de apenas 1 linha por vez
        + Tamanho da string da chave
        + Número máximo de elementos
        + Inclui botões para múltipla seleção
        + Define se será montado através de um X3_CBOX
        + Qual é o campo para montagem das opções
        + Não permite ordenação
        + Não permite pesquisar
        + Força o retorno como Array
        + Acionado em consulta F3
    Retorno
        Retorna .T. se foi confirmado ou .F. se foi cancelado
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe261()
    Local aArea      := FWGetArea()
    Local aRet       := {}
    Local cTitulo    := "Regiões do Brasil"
    Local aOpc       := {}
    Local cRet       := ""

    //Define as opções que serão exibidas
    aAdd(aOpc, "Norte")
    aAdd(aOpc, "Nordeste")
    aAdd(aOpc, "Centro Oeste")
    aAdd(aOpc, "Sudeste")
    aAdd(aOpc, "Sul")

    //Define as opções de retorno (conforme o aOpc acima)
    cRet := "000000001000000002000000003000000004000000005"

    //Abre a tela para a seleção
    If F_Opcoes(@aRet       ,;    //uVarRet
                cTitulo     ,;    //cTitulo
                aOpc        ,;    //aOpcoes
                cRet        ,;    //cOpcoes
                12          ,;    //nLin1
                49          ,;    //nCol1
                .T.         ,;    //l1Elem
                9           ,;    //nTam
                999         ,;    //nElemRet
                .F.         ,;    //lMultSelect
                .F.         ,;    //lComboBox
                Nil         ,;    //cCampo
                .F.         ,;    //lNotOrdena
                .F.         ,;    //lNotPesq
                .T.         ,;    //lForceRe
                Nil          ;    //cF3
        )

        FWAlertInfo("A opção marcada foi " + aRet[1], "Teste F_Opcoes")
    EndIf

    FWRestArea(aArea)
Return
