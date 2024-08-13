/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/07/funcao-alias-que-retorna-o-alias-de-uma-tabela-aberta-em-memoria-maratona-advpl-e-tl-030/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe030
Exemplo de função para retornar o nome de uma tabela
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.totvs.com/display/tec/Alias
@obs Função Alias
    Parâmetros
        + nWorkArea (Opcional), Numérico , Número da Área de Trabalho buscado (se não for passado nada, será buscado o último alias aberto)
    Retorno
        + cAlias              , Caractere, Retorna o nome do Alias    

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe030()
    Local aArea     := FWGetArea()
    Local cPriAlias := ""
    Local cUltAlias := ""

    //Abre algumas tabelas
    DbSelectArea("SA1")
    DbSelectArea("SA2")
    DbSelectArea("SA3")
    DbSelectArea("SA4")
    DbSelectArea("SB1")
    DbSelectArea("SB2")

    //Busca o primeiro e ultimo alias abertos pelo Protheus
    cPriAlias := Alias(1)
    cUltAlias := Alias()

    //Exibe os dois alias
    FWAlertInfo("cPriAlias: " + cPriAlias + ", cUltAlias: " + cUltAlias, "Função Alias")

    FWRestArea(aArea)
Return
