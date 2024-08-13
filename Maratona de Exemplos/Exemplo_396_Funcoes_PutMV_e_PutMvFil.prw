/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/05/alterando-parametros-com-as-funcoes-putmv-e-putmvfil-maratona-advpl-e-tl-396/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe396
Altera o conteúdo de um parâmetro da SX6
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=24347029
@obs 

    Função PutMV
    Parâmetros
        Nome do parâmetro na SX6
        Novo conteúdo que será atribuído
    Retorno
        Retorna .T. se conseguiu atualizar ou .F. se não

    Função PutMVFil
    Parâmetros
        Nome do parâmetro na SX6
        Novo conteúdo que será atribuído
        Código da filial em que será atribuído o parâmetro
    Retorno
        Retorna .T. se conseguiu atualizar ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe396()
    Local aArea     := FWGetArea()
    
    //Altera o conteúdo de um parâmetro
    PutMV("MV_ACENTO", "S")

    //Altera o conteúdo de um parâmetro em uma determinada filial
    PutMVFil("MV_ULTDEPR", Date(), "01")

    FWRestArea(aArea)
Return
