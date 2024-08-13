/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/12/16/abrindo-um-alias-com-a-funcao-dbselectarea-maratona-advpl-e-tl-130/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe130
Abre uma tabela, ou se ja estiver aberta, apenas posiciona na memória
@type Function
@author Atilio
@since 14/12/2022
@see https://tdn.totvs.com/display/tec/DBSelectArea
@obs 
    Função DbSelectArea
    Parâmetros
        + xArea        , Indefinido   , Pode ser o nome do alias (ex.: "SA1"; "SB1"; "SD2"; "QRY_TAB"; etc) ou o número dele aberto em memória (ex.: 3; 2; 7; etc)
    Retorno
        Não possui retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe130()
    Local aArea      := FWGetArea()
    
    //Abre várias tabelas
    DbSelectArea("SBM")
    DbSelectArea("SB1")
    DbSelectArea("SB2")
    DbSelectArea("SA1")
    DbSelectArea("SA2")
    DbSelectArea("SA4")

    //Posiciona em uma tabela que foi aberta
    DbSelectArea("SB1")

    //Mostra qual é a última tabela aberta
    FWAlertInfo("A tabela que está apontada na memória é: " + Alias(), "Teste DbSelectArea")

    FWRestArea(aArea)
Return
