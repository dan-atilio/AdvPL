/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/25/definindo-o-nome-da-funcao-em-execucao-com-a-setfunname-maratona-advpl-e-tl-436/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe436
Define o nome da função executada no menu
@type Function
@author Atilio
@since 30/03/2023
@obs 
    Função SetFunName
    Parâmetros
        Recebe o nome da função que será atribuída
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe436()
    Local aArea     := FWGetArea()
    Local cFunBkp   := ""

    //Faz o backup da função em memória
    cFunBkp := FunName()

    //Define o nome da função
    SetFunName("zDaniel")
    FWAlertInfo("Nome da função do Menu alterada (pressione Shift+F6 para conferir)!", "Teste FunName")

    //Restaura o Backup
    SetFunName(cFunBkp)

    FWRestArea(aArea)
Return
