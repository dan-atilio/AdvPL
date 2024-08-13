/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/29/validando-se-um-caractere-pertence-a-uma-expressao-com-a-pertence-maratona-advpl-e-tl-384/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe385
Realiza a conversão de uma string feita pelo Soma1 (sequencial entre números e caracteres) para o tipo numérico (igual a DecodeSoma1)
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815019
@obs 
    Função PesqPict
    Parâmetros
        Alias da Tabela
        Nome do Campo
    Retorno
        Máscara encontrada

    Função X3Picture
    Parâmetros
        + cCampo , Caractere     , Nome do Campo
    Retorno
        + cRet   , Caractere     , Máscara encontrada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe385()
    Local aArea      := FWGetArea()
    Local cMascara   := ""

    //Busca a picture do campo
    cMascara := PesqPict("SA1", "A1_CEP")
    FWAlertInfo("A mascara encontrada foi '" + cMascara + "'", "Teste PesqPict")

    //Busca a picture do campo
    cMascara := X3Picture("A1_LC")
    FWAlertInfo("A mascara encontrada foi '" + cMascara + "'", "Teste X3Picture")

    FWRestArea(aArea)
Return
