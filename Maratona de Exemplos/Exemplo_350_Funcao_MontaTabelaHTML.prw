/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/12/buscando-o-mes-com-a-funcao-month-maratona-advpl-e-tl-351/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe350
Monta uma tabela em HTML conforme um array passado
@type Function
@author Atilio
@since 25/03/2023
@obs 

    Função MontaTabelaHTML
    Parâmetros
        Recebe um Array com os dados da tabela
        Define se na primeira linha será o cabeçalho
        Define a largura em pixels da tabela
    Retorno
        Retorna uma string com as tags montadas em HTML

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe350()
	Local aArea     := FWGetArea()
    Local cMensagem := ""
    Local aDados    := {}
    
    //Abre a tabela de produtos
    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) //Filial + Código
    SB1->(DbGoTop())

    //Adiciona a linha de cabeçalho
    aAdd(aDados, {"Código", "Descrição", "U.M."})

    //Enquanto houver dados no cadastro de produtos
    While ! SB1->(EoF())
        //Adiciona a linha no array
        aAdd(aDados, {SB1->B1_COD, SB1->B1_DESC, SB1->B1_UM})

        SB1->(DbSkip())
    EndDo
    
    //Aciona a montagem do HTML passando o array, defindindo que tem cabeçalho e uma largura de 800 pixels
    cMensagem := MontaTabelaHTML(aDados, .T., "800")

    //Grava o html numa pasta do sistema operacional para testes
    MemoWrite("C:\spool\tabela.html", cMensagem)

    FWRestArea(aArea)
Return
