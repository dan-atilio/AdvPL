/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/21/buscando-o-conteudo-de-um-parametro-de-uma-filial-com-a-nggetmvpar-maratona-advpl-e-tl-368/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe368
Busca o conteúdo de um parâmetro em uma empresa e filial específica
@type Function
@author Atilio
@since 27/03/2023
@obs 

    Função NgGetMvPar
    Parâmetros
        Numero da Empresa (o mesmo que cEmpAnt)
        Numero da Filial (o mesmo que cFilAnt)
        Nome do parametro a ser pesquisado
        Valor default caso não encontre o parâmetro
    Retorno
        Retorna o conteúdo do parâmetro

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe368()
    Local aArea     := FWGetArea()
    Local cConteudo := ""

    //Busca o parâmetro na empresa 99 e filial 01
    cConteudo := NGGetMvPar("99", "01", "MV_X_PARAM", "CONTEUDO DEFAULT")

    //Exibe em uma mensagem
    FWAlertInfo("O conteúdo do parâmetro é '" + cConteudo + "'", "Teste NGGetMvPar")
 
    FWRestArea(aArea)
Return
