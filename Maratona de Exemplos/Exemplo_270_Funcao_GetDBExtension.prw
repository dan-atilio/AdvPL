/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/03/buscando-a-extensao-usada-para-banco-local-com-a-getdbextension-maratona-advpl-e-tl-270/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe270
Retorna o nome da extensão de arquivos (caso use arquivos locais como os antigos dtc ou dbf)
@type  Function
@author Atilio
@since 21/02/2023
@see https://tdn.totvs.com/display/tec/GetDBExtension
@obs 

    Função GetDBExtension
    Parâmetros
        Não tem parâmetros
    Retorno
        + cRet           , Caractere        , Retorna a extensão dos arquivos
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe270()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""

    //Busca a informação e exibe
    cMensagem := "A extensão de arquivos usadas é: " + GetDBExtension()
    FWAlertInfo(cMensagem, "Teste GetDBExtension")

    FWRestArea(aArea)
Return
