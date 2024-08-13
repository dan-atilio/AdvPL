/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/27/buscando-informacoes-de-relacionamentos-com-a-jurrelasx9-maratona-advpl-e-tl-318/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe318
Retorna informações da relacionamentos (SX9)
@type Function
@author Atilio
@since 25/02/2023
@obs 
    JurRelaSX9
    Parâmetros
        Recebe o alias da tabela
        Recebe se deve retornar a descrição (nome) da Tabela (.T.) ou não (.F.)
        Define qual vai ser o tipo de relacionamento a ser buscado pela origem (X9_DOM) ou pelo destino (X9_CDOM)
    Retorno
        Retorna um Array com as informações

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe318()
    Local aArea      := FWGetArea()
    Local aDados     := ""

    //Monta a mensagem e exibe
    aDados := JurRelaSX9("SC5", .T., 1)
    FWAlertInfo("Foi encontrado [" + cValToChar(Len(aDados)) + "] relacionamentos com a SC5", "Teste JurRelaSX9")

    FWRestArea(aArea)
Return
