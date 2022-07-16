//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0042
Função de exemplo, manipulação de strings
@type  Function
@author Atilio
@since 16/06/2022
/*/

User Function zVid0042()
    Local aArea  := FWGetArea()
    Local cTexto := '{"nome":"daniel", "empresa":"atilio sistemas", "site":"https://atiliosistemas.com", "contatos":[{"email":"contato@atiliosistemas.com"}, {"email":"suporte@terminaldeinformacao.com"}]}'
    Local cQuery := " SELECT * FROM SBM990 WHERE D_E_L_E_T_ = ' ' "
    Local cNome  := 'Daniel'

    //Colocar break point na linha abaixo e ver o conteúdo das 3 variáveis em memória
    Alert(cTexto + CRLF + cQuery + CRLF + cNome)

    FWRestArea(aArea)
Return
