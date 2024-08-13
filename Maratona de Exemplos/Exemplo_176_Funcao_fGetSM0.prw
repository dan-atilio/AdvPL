/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/16/buscando-as-empresas-que-o-usuario-tem-acesso-atraves-da-fgetsm0-maratona-advpl-e-tl-176/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe176
Retorna um array com os dados das empresas que o usuário tem acesso (através da FWLoadSM0)
@type Function
@author Atilio
@since 20/12/2022
@obs 
    Função fGetSM0
    Parâmetros
        + Define se irá filtrar somente o que for da mesma cEmpAnt logada
    Retorno
        + Retorna um array com os campos da SM0 (consultar FWLoadSM0 para saber as posições)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe176()
    Local aArea      := FWGetArea()
    Local aDados     := {}

    //Busca os dados da empresa
    aDados := fGetSM0()
    FWAlertInfo("Foi encontrado " + cValToChar(Len(aDados)) + " empresa(s)", "Teste com fGetSM0")

    FWRestArea(aArea)
Return
