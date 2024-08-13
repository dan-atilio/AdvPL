/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/17/convertendo-um-arquivo-do-servidor-para-array-com-filesrvtoarr-maratona-advpl-e-tl-179/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe178
Verifica se um arquivo existe
@type Function
@author Atilio
@since 20/12/2022
@see https://tdn.totvs.com/display/tec/File
@obs 
    Função File
    Parâmetros
        + cArquivo     , Caractere   , Nome do arquivo completo com a pasta (pode ser local ou dentro da Protheus Data)
        + nWhere       , Numérico    , Indica onde será feito a pesquisa do arquivo (0=acesso conforme path; 1=diretório de instalação do AppServer; 2=Diretório de instalação do SmartClient)
        + lChangeCase  , Lógico      , Se for .T. o nome será convertido tudo para minúsculo senão se for .F. mantém o nome original como veio
    Retorno
        + lRet         , Lógico      , Retorna .T. se o arquivo existir ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe178()
    Local aArea     := FWGetArea()
    Local cArqCompl := "C:\spool\relatorio.pdf"

    //Verifica se o arquivo existe
    If File(cArqCompl)
        FWAlertSuccess("Arquivo encontrado", "Teste File")

    Else
        FWAlertError("Arquivo não encontrado", "Teste File")
    EndIf

    FWRestArea(aArea)
Return
