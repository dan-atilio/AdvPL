/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/21/fazendo-backup-dos-parametros-em-memoria-com-ngsalvamvpa-e-ngretaumvpa-maratona-advpl-e-tl-369/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe369
Exemplo de função que armazena o conteúdo dos parâmetros em um backup sendo possível depois retornar esse backup
@type Function
@author Atilio
@since 30/11/2022
@obs 
    Função AtfSaveMvVar
        * Não possui parâmetros, nem retorno *

    Função AtfRestMvPar
        * Não possui parâmetros, nem retorno *

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe369()
    Local aArea      := FWGetArea()
    Local cMensagem  := ""
    
    //Mostra uma pergunta qualquer ao usuário
    Pergunte("A311TES", .F.)
    cMensagem += "Após o Pergunte da A311TES, o MV_PAR02 é '" + MV_PAR02 + "' " + CRLF

    //Faz um backup dos MV_PAR em memória
    aBackup := NgSalvaMvPa()
    cMensagem += "Foi realizado um backup" + CRLF

    //Aqui pode ser feito outras tratativas, acionar ParamBox, Pergunte, etc
    Pergunte("A410INCREM", .F.)
    cMensagem += "Após o Pergunte da A410INCREM, o MV_PAR02 é '" + MV_PAR02 + "' " + CRLF

    //Volta esse backup que estava em memória
    NgRetAuMVPa(aBackup)
    cMensagem += "Após o voltar o Backup, o MV_PAR02 é '" + MV_PAR02 + "' " + CRLF

    ShowLog(cMensagem)

    FWRestArea(aArea)
Return
