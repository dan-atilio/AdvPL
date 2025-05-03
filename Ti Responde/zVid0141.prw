/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/04/10/como-usar-as-funcoes-putglbvalue-e-getglbvalue-ti-responde-0141/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid141P
Exemplo de criação de variável pública
@type  Function
@author Atilio
@since 01/04/2024
/*/

User Function zVid141P()
    Local aArea := FWGetArea()

    //Cria uma variável pública na memória
    PutGlbValue("cXNomSobr", "Daniel Atilio")

    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function zVid141G
Exemplo de busca de variável pública
@type  Function
@author Atilio
@since 01/04/2024
/*/

User Function zVid141G()
    Local aArea := FWGetArea()
    Local cNome := ""

    //Busca a variável pública na memória
    cNome := GetGlbValue("cXNomSobr")

    //Mostra uma mensagem
    FWAlertInfo("O nome é " + cNome, "Teste GetGlbValue")

    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function zVid141G
Exemplo de busca de quantidade de segundos desde a última atualização da variável pública
@type  Function
@author Atilio
@since 01/04/2024
/*/

User Function zVid141T()
    Local aArea     := FWGetArea()
    Local nSegundos := 0

    //Busca o tempo
    nSegundos := TimeGlbValue("cXNomSobr")

    //Mostra uma mensagem
    FWAlertInfo("A quantidade de segundos é " + cValToChar(nSegundos), "Teste TimeGlbValue")

    FWRestArea(aArea)
Return
