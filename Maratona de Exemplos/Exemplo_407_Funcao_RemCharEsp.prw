/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/10/removendo-pontuacoes-com-a-remcharesp-maratona-advpl-e-tl-407/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe407
Remove pontuações de uma string, por exemplo: ., []()-
@type Function
@author Atilio
@since 28/03/2023
@obs 

    Função RemCharEsp
    Parâmetros
        Recebe a string a ser verificado
    Retorno
        A string sem pontuações

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe407()
    Local aArea     := FWGetArea()
    Local cFrase    := "A aranha arranha a rã. A rã arranha a aranha. Nem a aranha arranha a rã. Nem a rã arranha a aranha."
    Local cFraseNov := ""
    
    //Remove as pontuacoes e exibe: ., []()-
    cFraseNov := RemCharEsp(cFrase)
    FWAlertInfo("A frase ficou " + cFraseNov, "Teste RemCharEsp")

    FWRestArea(aArea)
Return
