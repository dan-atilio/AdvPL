/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/23/buscando-empresa-e-filial-conforme-cnpj-atraves-da-searchsm0-maratona-advpl-e-tl-432/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe432
Busca empresa e filial conforme CNPJ passado
@type Function
@author Atilio
@since 30/03/2023
@obs 
    Função SearchSM0
    Parâmetros
        Recebe o número do CNPJ
    Retorno
        Retorna um Array com várias linhas sendo que na coluna [1] é o código da empresa e coluna [2] é o código da filial

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe432()
    Local aArea    := FWGetArea()
    Local cCNPJ    := "00000000000000" // 00.000.000/0000-00
    Local aDados   := {}

    //Busca o código da empresa e filial conforme CNPJ
    aDados := SearchSM0(cCNPJ)

    //Verifica se tem dados no Array
    If ! Empty(aDados)
        FWAlertSuccess("Foi encontrado informações com o CNPJ = [" + aDados[1][1] + "/" + aDados[1][2] + "]", "Teste - SearchSM0")
    Else
        FWAlertError("CNPJ não encontrado na tabela SYS_COMPANY / SM0", "Falha - SearchSM0")
    EndIf

    FWRestArea(aArea)
Return
