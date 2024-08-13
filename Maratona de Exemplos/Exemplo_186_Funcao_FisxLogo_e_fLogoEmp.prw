/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/21/buscando-o-logo-da-empresa-com-as-funcoes-fisxlogo-e-flogoemp-maratona-advpl-e-tl-186/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe186
Retorna o logo da empresa
@type Function
@author Atilio
@since 21/12/2022
@obs 
    Função FisxLogo
    Parâmetros
        + Tipo do logo (1 = da empresa ; 2 = da TOTVS)
    Retorno
        + Retorna o nome do arquivo

    Função fLogoEmp
    Parâmetros
        + Nome do arquivo
        + Tipo do logo (1 = da empresa ; 2 = da TOTVS)
    Retorno
        Função não tem retorno



    Se o tipo for 1, ele irá retornar:
        LGRL + Empresa + Filial (exemplo: LGRL010101.bmp)
        ou
        LGRL + Empresa (exemplo: LGRL01.bmp)
    
    Se o tipo for 2, ele irá retornar:
        LogoSiga.bmp

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe186()
    Local aArea     := FWGetArea()
    Local cLogo     := ""

    //Busca o logo com FisxLogo
    cLogo := FisxLogo()
    FWAlertInfo("O logo da empresa é '" + cLogo + "'", "Teste FisxLogo")

    //Busca o logo com fLogoEmp
    cLogo := ""
    fLogoEmp(@cLogo)
    FWAlertInfo("O logo da empresa é '" + cLogo + "'", "Teste fLogoEmp")

    FWRestArea(aArea)
Return
