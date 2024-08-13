/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/03/buscando-o-codigo-da-filial-logada-com-fwcodfil-maratona-advpl-e-tl-212/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe212
Exemplo de função que traz o código da filial logada
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815110
@obs 
    Função FWCodFil
    Parâmetros
        + cGrpCompany  , Caractere , Indica o grupo de empresas a ser validado
        + cEmpUDFil    , Caractere , Indica a empresa; unidade de negócio e filial
    Retorno
        + cCodFil   , Caractere , Código da Filial

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe212()
    Local aArea    := FWGetArea()
    Local cEmprLog := ""
    Local cFiliLog := ""
    Local cMensag  := ""

    //Pega a empresa logada
    cEmprLog := FWCodEmp()

    //Pega a filial logada
    cFiliLog := FWCodFil()

    //Exibe uma mensagem
    cMensag := "Estou logado na empresa '" + cEmprLog + "' e na filial '" + cFiliLog + "'!"
    FWAlertInfo(cMensag, "Teste de FWCodFil")

    FWRestArea(aArea)
Return
