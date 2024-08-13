/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/15/apagando-arquivos-e-verificando-erros-com-ferase-e-ferror-maratona-advpl-e-tl-174/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe174
Função que apaga um arquivo
@type Function
@author Atilio
@since 20/12/2022
@see https://tdn.totvs.com/display/tec/FErase e https://tdn.totvs.com/display/tec/FError
@obs 
    Função FErase
    Parâmetros
        + cArquivo     , Caractere   , Nome do arquivo completo com a pasta (pode ser local ou dentro da Protheus Data)
        + xParam       , Indefinido  , Compatibilidade
        + lChangeCase  , Lógico      , Se for .T. o nome será convertido tudo para minúsculo senão se for .F. mantém o nome original como veio
    Retorno
        + nRet         , Numérico    , Retorna 0 se foi com sucesso ou -1 se houve falha

    Função FError
    Parâmetros
        Não tem parâmetros
    Retorno
        + nRet         , Numérico    , Retorna o número da operação de -1 a 690

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe174()
    Local aArea     := FWGetArea()
    Local cArqCompl := "C:\spool\relatorio.pdf"

    //Tenta fazer a exclusão do arquivo
    If FErase(cArqCompl) == 0
        FWAlertSuccess("Arquivo foi excluído com sucesso", "Teste FErase")

    Else
        FWAlertError("Houve uma falha na exclusão do arquivo, erro #" + cValToChar(FError()), "Teste FErase")
    EndIf

    FWRestArea(aArea)
Return
