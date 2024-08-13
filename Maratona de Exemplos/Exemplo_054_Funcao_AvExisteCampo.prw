/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/01/validando-se-campos-existem-no-dicionario-com-a-funcao-avexistecampo-maratona-advpl-e-tl-054/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe054
Exemplo de função que verifica se campos existem no dicionário
@type Function
@author Atilio
@since 05/12/2022
@obs 
    Função AvExisteCampo 
    Parâmetros
        + Array com o nome dos campos a serem verificados
    Retorno
        + Retorna .T. se encontrou todos os campos ou .F. se algum campo não existe na base

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe054()
    Local aArea            := FWGetArea()
    Local aCampos          := {}
    
    //Adiciona os campos que serão verificados
    aAdd(aCampos, "B1_COD")
    aAdd(aCampos, "B1_DESC")
    aAdd(aCampos, "B1_GRUPO")
    aAdd(aCampos, "B1_X_TST")

    //Faz a validação se os campos existem
    If AvExisteCampo(aCampos)
        FWAlertSuccess("Todos os campos existem na base", "Sucesso")
    Else
        FWAlertError("Existe(m) campo(s) não encontrado(s) na base!", "Falha")
    EndIf

    FWRestArea(aArea)
Return
