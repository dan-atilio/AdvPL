/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/02/validando-se-funcoes-estao-compiladas-no-rpo-com-a-avexistefunc-maratona-advpl-e-tl-055/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe055
Exemplo de função que verifica se funções estão compiladas no repositório
@type Function
@author Atilio
@since 05/12/2022
@obs 
    Função AvExisteFunc
    Parâmetros
        + Array com o nome das funções
    Retorno
        + Retorna .T. se encontrou todas as funções ou .F. se alguma função não existe no RPO

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe055()
    Local aArea            := FWGetArea()
    Local aFuncoes         := {}
    
    //Adiciona as funções que serão verificadas
    aAdd(aFuncoes, "MATA010")
    aAdd(aFuncoes, "MATA020")
    aAdd(aFuncoes, "u_zExe055")

    //Faz a validação se as funções existem
    If AvExisteFunc(aFuncoes)
        FWAlertSuccess("Todas as funções existem no RPO", "Sucesso")
    Else
        FWAlertError("Existe(m) função(ões) não encontrada(s) no RPO!", "Falha")
    EndIf

    FWRestArea(aArea)
Return
