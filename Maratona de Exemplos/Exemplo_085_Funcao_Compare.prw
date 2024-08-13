/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/01/comparacao-de-duas-variaveis-inclusive-objeto-usando-compare-maratona-advpl-e-tl-085/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe085
Exemplo de como comparar duas variáveis (inclusive objetos, arrays e blocos de código)
@type Function
@author Atilio
@since 09/12/2022
@obs 
    Função Compare
    Parâmetros
        + Informa a variável que irá comparar (array, objeto, bloco de código, numérico, caractere, lógico e data)
        + Informa a variável que será comparada (array, objeto, bloco de código, numérico, caractere, lógico e data)
        + Caso seja um array e você quiser ver qual a posição que esta diferente passe esse atributo com o @
    Retorno
        + Retorna .F. se houver diferença e .T. se estiver igual

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe085()
    Local aArea     := FWGetArea()
    Local oFont1
    Local oFont2
    Local aArray1   := {}
    Local aArray2   := {}
    Local nPosDif   := 0

    //Instancia a classe TFont em dois objetos
    oFont1 := TFont():New("Tahoma", , -12)
    oFont2 := TFont():New("Tahoma", , -12)

    //Compara os dois objetos
    If Compare(oFont1, oFont2)
        FWAlertSuccess("Os dois objetos são iguais", "Teste Compare com Objetos")
    Else
        FWAlertError("Os dois objetos são diferentes", "Teste Compare com Objetos")
    EndIf



    //Monta os dois arrays
    aAdd(aArray1, "Daniel")
    aAdd(aArray1, "João")
    aAdd(aArray1, "Maria")
    
    aAdd(aArray2, "Daniel")
    aAdd(aArray2, "José")
    aAdd(aArray2, "Maria")
    
    //Compara os dois arrays
    If Compare(aArray1, aArray2, @nPosDif)
        FWAlertSuccess("Os dois arrays são iguais", "Teste Compare com Arrays")
    Else
        FWAlertError("Os dois arrays são diferentes, primeira diferença encontrada em " + cValToChar(nPosDif), "Teste Compare com Arrays")
    EndIf

    FWRestArea(aArea)
Return
