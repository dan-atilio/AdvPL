/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/07/12/fazendo-um-laco-de-repeticao-com-while-e-enddo-maratona-advpl-e-tl-532/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe533
Retorna a pasta padrão de relatórios conforme a chave WSPReldir no environment ou nas configurações como MV_RELT
@type Function
@author Atilio
@since 07/04/2023
@see https://tdn.totvs.com/display/tec/WSPLReldir
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/


User Function zExe533()
	Local aArea   := FWGetArea()
	Local cPasta  := ""

    //Busca a pasta e exibe
    cPasta := WSPLRelDir()
    FWAlertInfo("A pasta de relatórios é: " + cPasta, "Teste WSPLRelDir")
	
	FWRestArea(aArea)
Return
