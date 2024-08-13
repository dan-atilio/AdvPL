/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/08/funcoes-aliascpo-e-prefixocpo-para-buscar-informacoes-conforme-campo-maratona-advpl-e-tl-031/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe031
Exemplo de função para retornar o nome de uma tabela conforme o campo usando as funções AliasCPO e PrefixoCPO
@type Function
@author Atilio
@since 28/11/2022
@obs 
    Função AliasCpo
    Parâmetros
        + Nome do Campo que você deseja buscar o Alias
    Retorno
        + Retorna o nome do Alias

    Função PrefixoCpo
    Parâmetros
        + Nome do Alias que você desejar saber o prefixo de campo
    Retorno
        + Retorna o prefixo usado nos campos

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe031()
    Local aArea     := FWGetArea()
    Local cTstAlias := ""
    Local cTstPrefi := ""

    //Busca o Alias conforme nome de um campo
    cTstAlias := AliasCpo("C5_EMISSAO")

    //Busca o Prefixo conforme o nome da tabela
    cTstPrefi := PrefixoCPO("SB1")

    //Mostra o resultado
    FWAlertInfo("cTstAlias é " + cTstAlias + ", cTstPrefi é " + cTstPrefi, "Resultado AliasCPO e PrefixoCPO")

    FWRestArea(aArea)
Return
