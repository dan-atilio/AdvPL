/*
    Esse exemplo faz parte da s�rie do YouTube, Maratona de Exemplos, do canal Terminal de Informa��o, 
    caso queira ver esse exemplo rodando em v�deo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/10/02/validando-se-funcoes-estao-compiladas-no-rpo-com-a-avexistefunc-maratona-advpl-e-tl-055/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe055
Exemplo de fun��o que verifica se fun��es est�o compiladas no reposit�rio
@type Function
@author Atilio
@since 05/12/2022
@obs 
    Fun��o AvExisteFunc
    Par�metros
        + Array com o nome das fun��es
    Retorno
        + Retorna .T. se encontrou todas as fun��es ou .F. se alguma fun��o n�o existe no RPO

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe055()
    Local aArea            := FWGetArea()
    Local aFuncoes         := {}
    
    //Adiciona as fun��es que ser�o verificadas
    aAdd(aFuncoes, "MATA010")
    aAdd(aFuncoes, "MATA020")
    aAdd(aFuncoes, "u_zExe055")

    //Faz a valida��o se as fun��es existem
    If AvExisteFunc(aFuncoes)
        FWAlertSuccess("Todas as fun��es existem no RPO", "Sucesso")
    Else
        FWAlertError("Existe(m) fun��o(�es) n�o encontrada(s) no RPO!", "Falha")
    EndIf

    FWRestArea(aArea)
Return
