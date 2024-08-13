/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/25/validando-se-esta-rodando-em-um-servidor-linux-com-issrvunix-maratona-advpl-e-tl-314/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zExe314
Valida se o servidor que esta rodando o AppServer é Linux / Unix-Like
@type  Function
@author Atilio
@since 23/02/2023
@see https://tdn.totvs.com/display/tec/IsSrvUnix
@obs 

    Função IsSrvUnix
    Parâmetros
        Não tem parâmetros
    Retorno
        + lRet      , Lógico      , .T. se tiver rodando em um ambiente Linux / Unix-Like ou .F. se não (Windows)

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe314()
	Local aArea      := FWGetArea()
    
    //Faz a validação onde o AppServer esta rodando
    If IsSrvUnix()
        FWAlertInfo("O AppServer esta rodando em um servidor Linux / Unix-Like", "Teste IsSrvUnix")
    Else
        FWAlertInfo("O AppServer esta rodando em um servidor Windows", "Teste IsSrvUnix")
    EndIf

    FWRestArea(aArea)
Return
