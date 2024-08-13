/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/03/validando-se-tabelas-existem-no-dicionario-com-avexistetab-maratona-advpl-e-tl-056/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe056
Exemplo de função que verifica se tabelas existem no dicionário
@type Function
@author Atilio
@since 05/12/2022
@obs 
    Função AvExisteTab
    Parâmetros
        + Array com o nome das tabelas a serem verificadas
    Retorno
        + Retorna .T. se encontrou todos as tabelas ou .F. se alguma tabela não existe na base

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe056()
    Local aArea            := FWGetArea()
    Local aTabelas          := {}
    
    //Adiciona os campos que serão verificados
    aAdd(aTabelas, "SB1")
    aAdd(aTabelas, "SA1")
    aAdd(aTabelas, "SA2")
    aAdd(aTabelas, "ZZZ")

    //Faz a validação se os campos existem
    If AvExisteTab(aTabelas)
        FWAlertSuccess("Todas as tabelas existem na base", "Sucesso")
    Else
        FWAlertError("Existe(m) tabela(s) não encontrada(s) na base!", "Falha")
    EndIf

    FWRestArea(aArea)
Return
