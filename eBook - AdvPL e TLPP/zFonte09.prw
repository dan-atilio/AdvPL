/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte09
Exemplo de como utilizar o operador & (E Comercial), para fazer uma macro execução / substituição
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/pages/viewpage.action?pageId=6063087
/*/

User Function zFonte09()
    Local aArea  := FWGetArea()
    Local nVar   := 10
    Local cTeste := "'Aaaa' + 'Bbbb'"
    Local cProgr := "FWAlertInfo"
    
    //Mostrando o conteúdo da variável com macro execução
    FWAlertInfo(&cTeste, "& Apenas variável")

    //Executando uma função
    &cProgr.("Atilio Sistemas", "& Apenas programa")

    //Executando uma expressão inteira
    &("FWAlertInfo('Mensagem de Teste', '& Expressão inteira')")

    FWRestArea(aArea)
Return
