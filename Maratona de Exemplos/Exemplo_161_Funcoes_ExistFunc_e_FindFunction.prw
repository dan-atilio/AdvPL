/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/08/validando-se-uma-tabela-existe-no-dicionario-com-a-funcao-existesx2-maratona-advpl-e-tl-160/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe161
Verifica se uma função existe no RPO
@type Function
@author Atilio
@since 19/12/2022
@see https://tdn.totvs.com/display/tec/Findfunction
@obs 
    Função ExistFunc
    Parâmetros
        + Nome da função a ser verificada
    Retorno
        + .T. Se a função foi encontrada ou .F. se ela não foi encontrada

    Função FindFunction
    Parâmetros
        + cFuncao      , Caractere   , Nome da função a ser verificada
    Retorno
        + lRet         , Lógico      , .T. Se a função foi encontrada ou .F. se ela não foi encontrada

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe161()
    Local aArea     := FWGetArea()

    //Se a função existir, aciona ela, senão mostra mensagem de erro
    If ExistFunc("u_zExe084")
        u_zExe084()
    Else
        FWAlertError("Função não encontrada", "Teste ExistFunc")
    EndIf

    //Se a função existir, aciona ela, senão mostra mensagem de erro
    If FindFunction("u_zExe084")
        u_zExe084()
    Else
        FWAlertError("Função não encontrada", "Teste FindFunction")
    EndIf
    
    FWRestArea(aArea)
Return
