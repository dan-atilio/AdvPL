/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/27/abrindo-uma-tela-para-marcacao-de-registros-com-a-f_opcoes-maratona-advpl-e-tl-261/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe260
Exemplo de como compactar arquivos para o formato .zip ou descompactar eles
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/tec/FZip e https://tdn.totvs.com/display/tec/FUnZip
@obs 

    Função FZip
    Parâmetros
		+ cArquivoZip    , Caractere       , Nome do arquivo que será criado
        + aArquivos      , Array           , Lista de arquivos que serão compactados
        + cBaseDir       , Caractere       , Diretório para não incluir dentro do arquivo
        + cSenha         , Caractere       , Define uma senha caso queira utilizar uma segurança criptografada
    Retorno
        + nRet           , Numérico        , Retorna 0 se conseguiu compactar

    Função FUnzip
    Parâmetros
		+ cArquivoZip    , Caractere       , Nome do arquivo que será descompactado
        + cPasta         , Caractere       , Nome da pasta onde será descompactado
        + cSenha         , Caractere       , Senha que será utilizada na descompactação (caso tenha sido utilizado na compactação)
    Retorno
        + nRet           , Numérico        , Retorna 0 se conseguiu descompactar
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe260()
    Local aArea      := FWGetArea()
    Local cArquiZip  := "C:\spool\teste.zip"
    Local aArquivos  := {}
    Local cSenhaZip  := "tst@123"
    Local nRetorno   := 0

    //Adiciona os arquivos que serão compactados
    aAdd(aArquivos, "C:\spool\log_auto.txt")
    

    //Faz a compactação dos arquivos e define uma senha
    nRetorno := FZip(cArquiZip, aArquivos, , cSenhaZip)
    If nRetorno == 0
        FWAlertSuccess("Sucesso na compactação!", "Teste FZip")
    Else
        FWAlertError("Falha na compactação!", "Teste FZip")
    EndIf

    //Agora faz a descompactação
    nRetorno := FUnZip(cArquiZip, "C:\spool\teste", cSenhaZip)
    If nRetorno == 0
        FWAlertSuccess("Sucesso na descompactação!", "Teste FUnZip")
    Else
        FWAlertError("Falha na descompactação!", "Teste FUnZip")
    EndIf

    FWRestArea(aArea)
Return
