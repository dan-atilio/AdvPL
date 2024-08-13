/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/26/alterando-o-modulo-em-execucao-atraves-da-setmodulo-maratona-advpl-e-tl-439/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe438
Busca a última pergunta que foi aberta em memória
@type Function
@author Atilio
@since 30/03/2023
@obs 
    Função SetLastPerg
    Parâmetros
        Define ser irá atualizar a pergunta com uma nova
    Retorno
        Retorna a última pergunta acionada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe438()
    Local aArea    := FWGetArea()
    Local cPergBkp := ""

    //Faz um backup da última pergunta
	cPergBkp := SetLastPerg()

    //Aciona outra pergunta
    If Pergunte("MTA440", .T.)
        // ...
    EndIf

    //Retorna o backup da pergunta
    Pergunte(cPergBkp, .F.)

	FWRestArea(aArea)
Return
