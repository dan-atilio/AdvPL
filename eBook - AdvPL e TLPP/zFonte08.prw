/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte08
Exemplo de como utilizar o operador $ (cifrão), para ver se um conteúdo texto está contido em outro
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
/*/

User Function zFonte08()
    Local aArea  := FWGetArea()
    Local cLetra := "a"
    Local cNome  := "ATILIO"

    //Se a letra estiver "contida" na variável do nome
    If cLetra $ cNome
        FWAlertInfo("A letra esta contida no Nome", "Teste 1")
    EndIf

    //Se a letra (tudo maiúscula) estiver "contida" na variável do nome (tudo maiúscula)
    If Upper(cLetra) $ (cNome)
        FWAlertInfo("A letra esta contida no Nome (variáveis tudo maiúsculas)", "Teste 2")
    EndIf

    FWRestArea(aArea)
Return
