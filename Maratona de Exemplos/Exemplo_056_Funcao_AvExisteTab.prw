/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/03/validando-se-tabelas-existem-no-dicionario-com-avexistetab-maratona-advpl-e-tl-056/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe056
Exemplo de fun��o que verifica se tabelas existem no dicion�rio
@type Function
@author Atilio
@since 05/12/2022
@obs 
    Fun��o AvExisteTab
    Par�metros
        + Array com o nome das tabelas a serem verificadas
    Retorno
        + Retorna .T. se encontrou todos as tabelas ou .F. se alguma tabela n�o existe na base

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe056()
    Local aArea            := FWGetArea()
    Local aTabelas          := {}
    
    //Adiciona os campos que ser�o verificados
    aAdd(aTabelas, "SB1")
    aAdd(aTabelas, "SA1")
    aAdd(aTabelas, "SA2")
    aAdd(aTabelas, "ZZZ")

    //Faz a valida��o se os campos existem
    If AvExisteTab(aTabelas)
        FWAlertSuccess("Todas as tabelas existem na base", "Sucesso")
    Else
        FWAlertError("Existe(m) tabela(s) n�o encontrada(s) na base!", "Falha")
    EndIf

    FWRestArea(aArea)
Return
