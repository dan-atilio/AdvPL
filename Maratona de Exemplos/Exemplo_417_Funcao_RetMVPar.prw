/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/15/buscando-os-modulos-do-sistema-com-a-retmodname-maratona-advpl-e-tl-416/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe417
Guarda as respostas de um Pergunte em um Array
@type Function
@author Atilio
@since 22/02/2023
@obs 

    Função RetMVPar
    Retorno
        Retorna um array com as respostas dos parâmetros do Pergunte

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe417()
    Local aArea      := FWGetArea()
    Local aResultado := {}

    //Aciona a pergunta em memória, e guarda o resultado
    Pergunte("A311TES", .F.)
    aResultado := RetMVPar()

    //Exibe uma mensagem de teste
    FWAlertInfo("Foi encontrado " + cValToChar(Len(aResultado)) + " resposta(s) ", "Teste RetMVPar")

    FWRestArea(aArea)
Return
