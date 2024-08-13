/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/28/buscando-ultimo-dia-do-mes-com-a-lastdate-maratona-advpl-e-tl-321/
*/


//Bibliotecas
#Include "Protheus.ch"
 
/*/{Protheus.doc} User Function zExe320
Formata uma string justificando o texto
@type Function
@author Atilio
@since 25/02/2023
@see https://tdn.totvs.com/display/tec/KillUser
@obs 
    KillUser
    Parâmetros
        + UserName       , Caractere    , Nome do usuário conectado no SmartClient
        + ComputerName   , Caractere    , Nome do computador que esta com o SmartClient aberto
        + ThreadId       , Numérico     , Indica o número da Thread entre ao AppServer e SmartClient
        + ServerName     , Caractere    , Indica o servidor onde esta rodando o AppServer
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe320()
    Local aArea      := GetArea()
    Local aThreads   := {}
    Local nConexAtu  := 1
    Local nTentativa := 1
    Local nMaxTenta  := 10
     
    //Pega todos os usuários conectados
    aThreads := GetUserInfoArray()
     
    //Enquanto houver tentativas para finalizar as threads
    While nTentativa <= nMaxTenta
        //Percorre todas as conexões
        For nConexAtu := 1 To Len(aThreads)
             
            //Se a thread da conexão atual for diferente da thread atual (senão vai matar o processo que mata todos)
            If aThreads[nConexAtu][3] != ThreadId()
                KillUser( aThreads[nConexAtu][1],; //UserName
                          aThreads[nConexAtu][2],; //ComputerName
                          aThreads[nConexAtu][3],; //ThreadId
                          aThreads[nConexAtu][4])  //ServerName
            EndIf
        Next
         
        //Pega novamente todos os usuários conectados
        aThreads := GetUserInfoArray()
         
        //Se ainda houver registros, aumenta a tentativa e espera 1 segundo
        If Len(aThreads) > 1
            nTentativa++
            Sleep(1000)
             
        //Senão finaliza o laço de repetição
        Else
            Exit
        EndIf
    EndDo
     
    RestArea(aArea)
Return
