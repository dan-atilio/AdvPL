/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/28/transformando-uma-string-aplicando-sha1-maratona-advpl-e-tl-443/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe443
Aplica um conteúdo transformando ele em SHA1 (Secure Hash Algorithm)
@type Function
@author Atilio
@since 31/03/2023
@see https://tdn.totvs.com/display/tec/SHA1
@obs 

    Função SHA1
    Parâmetros
        + cContent   , Caractere     , Indica o conteúdo que será aplicado o algoritmo
        + nRetType   , Numérico      , Indica o tipo de Hash (1=ASCII ou 2=Hexadecimal)
    Retorno
        + cDigest    , Caractere     , Retorna o hash do conteúdo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe443()
	Local aArea     := FWGetArea()
    Local cNome     := "Daniel"
    Local cHash     := ""

    //Mostra ele em SHA1 com o Tipo 1
    cHash := SHA1(cNome, 1)
    FWAlertInfo(cHash, "Teste 1 da função SHA1")

    //Mostra ele em SHA1 com o Tipo 2
    cHash := SHA1(cNome, 2)
    FWAlertInfo(cHash, "Teste 2 da função SHA1")

	FWRestArea(aArea)
Return
