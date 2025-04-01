/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte06
Exemplo de como utilizar o operador ; (Ponto e Vírgula), para continuar a execução na próxima linha
@type Function
@author Atilio
@since 26/11/2022
/*/

User Function zFonte06()
    Local aArea   := FWGetArea()
    Local cTexto  := ""
    Local aDados  := {}

    //Demonstra a continuação da linha na próxima através do ponto e vírgula
    cTexto := "O rato " + ;
        "roeu a roupa " + ;
        "do rei de Roma"
    FWAlertInfo(cTexto, "Conteúdo da variável cTexto")

    //Cria um array com vários elementos
    aDados := { ;
        "terminaldeinformacao.com", ;
        "autumncodemaker.com", ;
        "atiliosistemas.com" ;
    }
    FWAlertInfo("Tamanho do array: " + cValToChar(Len(aDados)), "Variável aDados")

    FWRestArea(aArea)
Return
