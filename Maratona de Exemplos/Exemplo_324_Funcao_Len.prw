/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/30/lendo-um-arquivo-texto-com-a-letxt-maratona-advpl-e-tl-325/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe324
Retorna o tamanho de uma variável (caractere ou array)
@type Function
@author Atilio
@since 11/03/2023
@see https://tdn.totvs.com/display/tec/Len
@obs 
    Função Len
    Parâmetros
        + xParam       , Indefinido , Variável que será avaliada
    Retorno
        + nCount       , Numérico   , Retorna o tamanho da variável

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe324()
    Local aArea     := FWGetArea()
    Local cNome     := "Daniel"
    Local aDados    := {"Daniel", "João", "Maria"}
    Local cMensagem := ""

    //Monta a mensagem pegando o tamanho de cada variável
    cMensagem := "cNome: "  + cValToChar( Len(cNome)  ) + CRLF
    cMensagem += "aDados: " + cValToChar( Len(aDados) ) + CRLF

    //Mostra o resultado
    FWAlertInfo(cMensagem, "Teste Len")

    FWRestArea(aArea)
Return
