/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/28/fazendo-um-backup-dos-alias-abertos-com-a-sgetarea-e-srestarea-maratona-advpl-e-tl-442/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe442
Faz um backup da área em memória e depois volta (de várias tabelas)
@type Function
@author Atilio
@since 31/03/2023
@obs 

    Função SGetArea
    Parâmetros
        Recebe o nome do Array que irá armazenar as áreas
        Recebe o alias que deverá ser adicionado no Array
    Retorno
        Retorna um array com cada tabela e com as posições [1] Alias ; [2] Índice Usado ; [3] Registro posicionado

    Função SRestArea
    Parâmetros
        Array com as posições igual armazenadas na SGetArea
    Retorno
        Não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe442()
    Local aArea    := {}
    
    //Adiciona as áreas no Array
    SGetArea(aArea, "SB1")
    SGetArea(aArea, "SBM")
    SGetArea(aArea, "SB5")
     
    //Aqui suas customizações
     
    SRestArea(aArea)
Return

/*/{Protheus.doc} User Function A010TOK
Ponto de entrada ao clicar no botão Ok no Cadastro de Produtos
@type  Function
@author Atilio
@since 31/03/2023
/*/

User Function A010TOK()
    Local lRet     := .T.

    //Seleciona outra tabela
    DbSelectArea("SA1")

    //Aciona o exemplo do GetArea e RestArea
    u_zExe442()

Return lRet
