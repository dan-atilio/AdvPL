/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/08/buscando-uma-linha-de-um-conteudo-memo-com-a-memoline-maratona-advpl-e-tl-343/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe342
Aplica um conteúdo transformando ele em MD5 (Message Digest Algorithm 5)
@type Function
@author Atilio
@since 22/03/2023
@see https://tdn.totvs.com/display/tec/MD5
@obs 

    Função MD5
    Parâmetros
        + cValor     , Caractere     , Indica o conteúdo que será aplicado o algoritmo
        + nType      , Numérico      , Indica o tipo de Hash (1=Binário ou 2=Hexadecimal)
    Retorno
        + cRet       , Caractere     , Retorna o hash do conteúdo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe342()
	Local aArea     := FWGetArea()
    Local cNome     := "Daniel"
    Local cHash     := ""

    //Mostra ele em MD5 com o Tipo 1 (bin)
    cHash := MD5(cNome, 1)
    FWAlertInfo(cHash, "Teste 1 da função MD5")

    //Mostra ele em MD5 com o Tipo 2 (hexa)
    cHash := MD5(cNome, 2)
    FWAlertInfo(cHash, "Teste 2 da função MD5")

	FWRestArea(aArea)
Return
