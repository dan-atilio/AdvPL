/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/28/funcao-_notags-para-remover-caracteres-especiais-em-html-maratona-advpl-e-tl-020/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe020
Exemplo de conversão de decimal para hexadecimal
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.totvs.com/pages/releaseview.action?pageId=173083053
@obs Função _NoTags
    Parâmetros
        + cTexto   , Caractere , Variável de origem que poderá ter conteúdo que será substituído
    Retorno
        + cRetorno , Caractere , Texto formatado, transformando os caracteres especiais

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe020()
    Local aArea        := FWGetArea()
    Local cTextoAnt    := "Empresa & CIA"
    Local cTextoDep

    //Retira caracteres especiais e mostra como ficou a mensagem
    cTextoDep := _NoTags(cTextoAnt)
    FWAlertError("Como ficou: " + cTextoDep, "Exemplo de _NoTags")

    FWRestArea(aArea)
Return
