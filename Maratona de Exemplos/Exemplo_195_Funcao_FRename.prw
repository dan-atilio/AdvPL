/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/25/renomeando-arquivos-com-a-funcao-frename-maratona-advpl-e-tl-195/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe195
Função que renomeia o arquivo
@type Function
@author Atilio
@since 11/02/2023
@see https://tdn.totvs.com/display/tec/FRename
@obs 
    Função FRename
    Parâmetros
        + cArquivo    , Caractere        , Nome do arquivo que será renomeado
        + cNovoArq    , Caractere        , Nome novo do arquivo
        + nParam3     , Indefinido       , Parâmetro mantido por compatibilidade
        + lChangeCase , Lógico           , Se .T. é convertido tudo para minúsculo senão mantém original
    Retorno
        + nRet        , Numérico         , Retorna 0 se a operação foi realizada com sucesso ou -1 se falhar

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe195()
    Local aArea     := FWGetArea()
    Local cArqOrig  := "C:\spool\tst.txt"
    Local cArqNovo  := "C:\spool\tst_novo.txt"
    Local nResult

    //Aciona a função para renomear os arquivos
    nResult := FRename(cArqOrig, cArqNovo)

    //Se foi renomeado com sucesso
    If nResult == 0
        FWAlertSuccess("Arquivo renomeado com sucesso!", "Teste FRename")
    Else
        FWAlertError("Houve uma falha ao renomear o arquivo, erro #" + cValToChar(FError()), "Teste FRename")
    EndIf

    FWRestArea(aArea)
Return
