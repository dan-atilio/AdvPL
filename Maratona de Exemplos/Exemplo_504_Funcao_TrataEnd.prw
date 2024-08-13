/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/06/28/criando-relatorios-com-treport-trfunction-trsection-e-trcell-maratona-advpl-e-tl-505/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe504
Trata um endereço retornando as informações separadas
@type Function
@author Atilio
@since 04/04/2023
@obs 

    TrataEnd
    Parâmetros
        Recebe o endereço junto com o numero e complemento separados por virgula
        Define se quer buscar o endereço / logradouro (L) ou o numero (N) ou o complemento (C)
    Retorno
        Retorna a parte do endereço encontrada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe504()
    Local aArea      := FWGetArea()
    Local cEndereco  := ""
    Local cBusca     := ""

    //Define o endereço, sendo que o numero e complemento separados por vírgula
    cEndereco := "Rua do Garibaldo, 369, Próximo ao Mercado"



    //Busca a informação do endereço (logradouro) apenas e exibe
    cBusca := TrataEnd(cEndereco, "L")
    FWAlertInfo(cBusca, "Teste 1 TrataEnd")



    //Busca a informação do número apenas e exibe
    cBusca := TrataEnd(cEndereco, "N")
    FWAlertInfo(cBusca, "Teste 2 TrataEnd")



    //Busca a informação do complemento apenas e exibe
    cBusca := TrataEnd(cEndereco, "C")
    FWAlertInfo(cBusca, "Teste 3 TrataEnd")

    FWRestArea(aArea)
Return
