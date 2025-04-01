/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zFonte02
Exemplo de utilização de comentários
@author Atilio
@since 01/02/2025
@version 1.0
@type function
/*/

User Function zFonte02()
	Local aArea    := FWGetArea()
	Local dDataAtu := Date()
	Local cHoraAtu := Time()
	Local cNome    := "eBook de AdvPL e TLPP"
	
	//Mostrando 3 mensagens com as variáveis criadas acima
	MsgInfo("Estamos no [" + cNome + "], hoje é " + dToC(dDataAtu) + ", às " + cHoraAtu, "Atenção")
	MsgInfo("Ontem seria " + dToC(DaySub(dDataAtu, 1)), "Atenção")
	MsgInfo("Mês passado seria " + dToC(MonthSub(dDataAtu, 1)), "Atenção")

    /*
        Exibindo 3 mensagens, utilizando a função MsgInfo
        Na primeira mensagem, vai exibir apenas uma observação com a data e hora
        Já nas outras duas, vai ser usado as funções DaySub e MonthSub para mostrar a data
        de ontem e do mês passado
    */
    MsgInfo("Estamos no [" + cNome + "], hoje é " + dToC(dDataAtu) + ", às " + cHoraAtu, "Atenção")
	MsgInfo("Ontem seria " + dToC(DaySub(dDataAtu, 1)), "Atenção")
	MsgInfo("Mês passado seria " + dToC(MonthSub(dDataAtu, 1)), "Atenção")
	
	FWRestArea(aArea)
Return
