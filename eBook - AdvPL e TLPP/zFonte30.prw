/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zFonte30
Exemplo de estrutura de condicao com Iif
@type  Function
@author Atilio
@since 22/02/2023
@see https://tdn.totvs.com/display/tec/iif
/*/

User Function zFonte30()
	Local aArea    := FWGetArea()
    Local nMesAtu  := Month(Date())
    Local nMesAniv := 7
    Local cMsg     := ""

    cMsg := Iif(nMesAtu == nMesAniv, "ANIVERSARIANTE", "AINDA NAO")
    FWAlertInfo(cMsg, "Teste de Iif")

    /*
    //Esse trecho, seria a linha do Iif acima
    If nMesAtu == nMesAniv
        cMsg := "ANIVERSARIANTE"
    Else
        cMsg := "AINDA NAO"
    EndIf
    */

    /*
    //Essa linha
    nValor := Iif(A == B, Iif(B == C, 7, Iif(C == D, 4, 9)), 3)

    //Seria o mesmo que esse trecho
    If A == B
        If B == C
            nValor := 7
        Else
            If C == D
                nValor := 4
            Else
                nValor := 9
            EndIf
        EndIf
    Else
        nValor := 3
    EndIf
    */  

    FWRestArea(aArea)
Return
