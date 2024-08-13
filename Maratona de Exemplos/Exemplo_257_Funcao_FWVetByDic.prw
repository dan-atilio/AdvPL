/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/25/transformando-um-texto-em-array-com-fwtxt2array-maratona-advpl-e-tl-256/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe257
Função que ordena um array de ExecAuto conforme a ordem de campos na SX3
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/public/framework/FWVetByDic
@obs 

    Função FWVetByDic
    Parâmetros
        + aVetor         , Caractere       , Array original com os campos e conteúdos do ExecAuto
        + cTable         , Caractere       , Alias da Tabela
		+ lItens         , Lógico          , .T. se for um array de itens ou .F. se não (por exemplo .T. se for SC6 e .F. se for SC5)
		+ nCpoPos        , Numérico        , Posição da coluna onde esta o nome do campo
    Retorno
        + aReturn        , Array           , Array ordenado conforme o dicionário
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe257()
    Local aArea     := FWGetArea()
    Local aDadosOrig := {}
    Local aDadosOrde := {}

    //Adiciona os campos
    aAdd(aDadosOrig, {"BM_DESC",    "Grupo Teste - Maratona", Nil})
    aAdd(aDadosOrig, {"BM_PROORI",  "1",                      Nil})
    aAdd(aDadosOrig, {"BM_CLASGRU", "1",                      Nil})
    aAdd(aDadosOrig, {"BM_GRUPO",   "X001",                   Nil})

    //Ordena os campos para ficar igual no dicionário
    aDadosOrde := FWVetByDic(aDadosOrig, "SBM")

    /*
    //Chama a inclusão
    MsExecAuto({|x, y| MATA035(x, y)}, aDadosOrde, 3)

    //Se houve erro, mostra a mensagem, e aborta o restante das operações
    If lMsErroAuto
        MostraErro()
    EndIf
    */

    FWRestArea(aArea)
Return
