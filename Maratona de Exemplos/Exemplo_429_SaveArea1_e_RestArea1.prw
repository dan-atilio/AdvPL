/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/21/fazendo-um-backup-dos-alias-em-memoria-com-savearea1-e-restarea1-maratona-advpl-e-tl-429/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe429
Faz um backup da área em memória e depois volta (de várias tabelas)
@type Function
@author Atilio
@since 29/03/2023
@obs 

    Função SaveArea1
    Parâmetros
        Recebe um array com os alias da tabela
    Retorno
        Retorna um array com cada tabela e com as posições [1] Alias ; [2] Índice Usado ; [3] Registro posicionado

    Função RestArea1
    Parâmetros
        Array com as posições igual armazenadas na SaveArea1
    Retorno
        Não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe429()
    Local aArea    := SaveArea1({"SB1", "SBM", "SB5"})
     
    //Aqui suas customizações
     
    RestArea1(aArea)
Return

/*/{Protheus.doc} User Function A010TOK
Ponto de entrada ao clicar no botão Ok no Cadastro de Produtos
@type  Function
@author Atilio
@since 29/03/2023
/*/

User Function A010TOK()
    Local lRet     := .T.

    //Seleciona outra tabela
    DbSelectArea("SA1")

    //Aciona o exemplo do GetArea e RestArea
    u_zExe429()

Return lRet
