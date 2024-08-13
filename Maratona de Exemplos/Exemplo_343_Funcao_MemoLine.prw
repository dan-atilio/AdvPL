/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/08/usando-a-funcao-md5-para-transformar-uma-string-maratona-advpl-e-tl-342/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe343
Retorna uma linha de uma string ou campo memo conforme parametrizações passadas
@type Function
@author Atilio
@since 22/03/2023
@see https://tdn.totvs.com/display/tec/MemoLine
@obs 

    Função MemoLine
    Parâmetros
        + cText       , Caractere     , Texto que será analisado
        + nLineLength , Numérico      , Tamanho máximo de caracteres por linha
        + nLineNumber , Numérico      , Número da linha buscada
        + nTabSize    , Numérico      , Tamanho da tabulação usada
        + lWrapWord   , Lógico        , Indica se palavras inteiras serão consideradas
    Retorno
        + cText      , Caractere     , Retorna a linha conforme os parâmetros informados

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe343()
	Local aArea     := FWGetArea()
    Local cFrase    := "A aranha arranha a rã. A rã arranha a aranha. Nem a aranha arranha a rã. Nem a rã arranha a aranha."
    Local nTamanho  := 20
    Local nLinha    := 0
    Local cAtual    := "." //Inicia com ponto só pra começar no While
    Local cMensagem := ""

    //Enquanto houver linhas a serem lidas
    While ! Empty(cAtual)
        //Incrementa a linha
        nLinha++

        //Busca a linha atual conforme o tamanho de caracteres definido
        cAtual := MemoLine(cFrase, nTamanho, nLinha)

        //Adiciona na mensagem
        If ! Empty(cAtual)
            cMensagem += "Linha " + cValToChar(nLinha) + ": " + cAtual + CRLF
        EndIf
    EndDo

    //Mostra a mensagem
    FWAlertInfo(cMensagem, "Teste MemoLine")

	FWRestArea(aArea)
Return
