/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/13/buscando-informacoes-de-uma-tabela-com-a-funcao-fdesc-maratona-advpl-e-tl-171/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe171
Função para trazer conteúdo de campos que existam no dicionário
@type Function
@author Atilio
@since 20/12/2022
@obs 
    Função fDesc
    Parâmetros
        + Alias da Tabela
        + Chave de pesquisa do registro
        + Campo(s) de Retorno
        + Máximo de caracteres a retornar
        + Filial base (se não for passado irá considerar xFilial)
        + Qual índice da tabela será usado na pesquisa
        + Define se irá posicionar na SX3
    Retorno
        + Retorna o conteúdo conforme os parametros informados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe171()
    Local aArea      := FWGetArea()
    Local cCodProd   := "F0003"
    Local cDesProd   := ""
    Local cCodCli    := "C00002"
    Local cLojCli    := "01"
    Local cDadCli    := ""
    Local cMensagem  := ""
    
    //Busca a descrição do produto e dados do cliente
    cDesProd := fDesc("SB1", cCodProd, "B1_DESC")
    cDadCli  := fDesc("SA1", cCodCli + cLojCli, "A1_NREDUZ + ';' + A1_TIPO + ';' + A1_NOME")

    //Monta a mensagem e exibe
    cMensagem := "cDesProd: " + cDesProd + CRLF
    cMensagem += "cDadCli: " + cDadCli
    FWAlertInfo(cMensagem, "Teste com fDesc")

    FWRestArea(aArea)
Return
