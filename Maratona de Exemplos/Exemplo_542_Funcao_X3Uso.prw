/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/17/transformando-um-no-de-xml-em-array-com-xmlnode2arr-maratona-advpl-e-tl-543/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe542
Valida se um campo esta marcado com a opção Usado
@type Function
@author Atilio
@since 07/04/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815021
@obs 

    Função X3Uso
    Parâmetros
        + cUsado    , Caractere  , Conteúdo do campo X3_USADO
        + nModulo   , Numérico   , Define o módulo que será usado para validar o uso do campo (se não for informado busca do módulo logado atualmente)
    Retorno
        + lRet      , Lógico     , Retorna .T. se o campo estiver marcado como Usado ou .T. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe542()
    Local aArea      := FWGetArea()
    Local cCampo     := ""
    Local cUsado     := ""

    //Define o campo e busca a informação de usado
    cCampo := "B1_GRUPO"
    cUsado := GetSX3Cache(cCampo, "X3_USADO")
    
    //Valida se o campo ta sendo usado nas telas do sistema
    If X3Uso(cUsado)
        FWAlertSuccess("O campo esta marcado como Usado", "Teste X3Uso")
    Else
        FWAlertError("Campo não sendo Usado", "Teste X3Uso")
    EndIf

    FWRestArea(aArea)
Return
