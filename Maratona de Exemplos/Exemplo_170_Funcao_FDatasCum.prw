/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/13/buscando-datas-de-um-intervalo-com-fdatascum-maratona-advpl-e-tl-170/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe170
Retorna as datas de um intervalo
@type Function
@author Atilio
@since 19/12/2022
@obs 
    Função FDatasCum
    Parâmetros
        + Período a ser validado sendo 1= Diário; 2= Compatibilidade (Semanal); 3= Decendial; 4= Mensal
        + Data de referência
    Retorno
        + Array com as datas do intervalo encontrado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe170()
    Local aArea      := FWGetArea()
    Local dDataRef   := Date()
    Local aDiario    := {}
    Local aDecendial := {}
    Local aMensal    := {}
    Local cMensagem  := ""

    //Busca os períodos
    aDiario    := FDatasCum("1", dDataRef)
    aDecendial := FDatasCum("3", dDataRef)
    aMensal    := FDatasCum("4", dDataRef)

    //Monta a mensagem com os períodos
    cMensagem += "Diario: " + CenArr2Str(aDiario[1], ";") + CRLF
    cMensagem += "Decendio: " + CenArr2Str(aDecendial[1], ";") + CRLF
    cMensagem += "Mensal: " + CenArr2Str(aMensal[1], ";")
    FWAlertInfo(cMensagem, "Teste com FDatasCum")

    FWRestArea(aArea)
Return
