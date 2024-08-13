/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/25/abrindo-tabelas-do-dicionario-com-a-opensxs-maratona-advpl-e-tl-377/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe376
Realiza a abertura de uma empresa em memória (para poder usar as tabelas)
@type Function
@author Atilio
@since 28/03/2023
@obs 

    Função OpenFile
    Parâmetros
        Recebe o número da empresa sendo formado pelo código da empresa + código da filial (variável pública cNumEmp)
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe376()
    Local aArea      := FWGetArea()
    Local cEmpBkp    := ""
    Local cFilBkp    := ""
    Local cNumEmpBkp := ""

    //1. Faz o backup das variáveis públicas
    cEmpBkp := cEmpAnt
    cFilBkp := cFilAnt
    cNumEmpBkp := cNumEmp
    
    //2. Altera as variáveis públicas
    cEmpAnt := "99" //"01"
    cFilAnt := "01" //"0201"
    cNumEmp := cEmpAnt + cFilAnt
    
    //3. Chama a função OpenFile para a nova filial
    OpenFile(cNumEmp)
    
    //4. Aqui você faz as suas customizações / tratativas
    // ...
    // ...
    // ...
    
    //5. Volta o backup das variáveis
    cEmpAnt := cEmpBkp
    cFilAnt := cFilBkp
    cNumEmp := cEmpAnt + cFilAnt
    
    //6. Chama a função OpenFile para voltar para a filial de origem
    OpenFile(cNumEmp)

    FWRestArea(aArea)
Return
