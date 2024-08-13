/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/19/buscando-a-estrutura-de-campos-de-uma-tabela-com-dbstruct-maratona-advpl-e-tl-133/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe133
Retorna a estrutura da tabela em um array
@type Function
@author Atilio
@since 15/12/2022
@see https://tdn.totvs.com/display/tec/DBStruct
@obs 
    Função DbStruct
    Parâmetros
        Não possui parâmetros
    Retorno
        + aRet        , Array   , Array sendo que as posições são: [1] Nome do Campo; [2] Tipo do Campo; [3] Tamanho do Campo; [4] Decimais do Campo;

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe133()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""
    Local aCampos    := {}
    Local nAtual     := 0

    //Abre o cadastro de grupo de produtos e busca a estrutura da tabela
    DbSelectArea("SBM")
    SBM->(DbSetOrder(1)) // Filial + Código do Grupo
    aCampos := SBM->(DbStruct())
    cMensagem += PadR("Campo", 11) + "|" + PadR("Tipo", 5) + "|" + PadR("Tamanho", 8) + "|" + PadR("Decimal", 8) + CRLF

    //Percorre todos os campos   
    For nAtual := 1 To Len(aCampos)
        cMensagem += PadR(aCampos[nAtual][1],             11) + "|"
        cMensagem += PadR(aCampos[nAtual][2],              5) + "|"
        cMensagem += PadR(cValToChar(aCampos[nAtual][3]),  8) + "|"
        cMensagem += PadR(cValToChar(aCampos[nAtual][4]),  8)
        cMensagem += CRLF
    Next

    //Exibe a mensagem
    ShowLog(cMensagem)

    FWRestArea(aArea)
Return
