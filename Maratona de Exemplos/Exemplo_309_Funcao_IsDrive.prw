/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/03/22/validando-se-um-drive-existe-com-isdrive-maratona-advpl-e-tl-309/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} zExe309
Valida se um drive (Windows) esta apto a receber gravações na raiz
@type  Function
@author Atilio
@since 23/02/2023
@obs 

    Função IsDrive
    Parâmetros
        Recebe a letra do drive sem o : (ao invés de C:\ enviar apenas C)
    Retorno
        Retorna .T. se o drive pode receber arquivos na raiz ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe309()
	Local aArea      := FWGetArea()
    Local cMensagem  := ""
    
    //Valida se o C:\ pode receber arquivos na raiz
    If IsDrive("C")
        cMensagem := "Arquivos podem ser gravados no C:\"
    Else
        cMensagem := "Não foi possível validar o C:\"
    EndIf
    FWAlertInfo(cMensagem, "Teste 1 IsDrive")

    //Valida se o F:\ pode receber arquivos na raiz
    If IsDrive("F")
        cMensagem := "Arquivos podem ser gravados no F:\"
    Else
        cMensagem := "Não foi possível validar o F:\"
    EndIf
    FWAlertInfo(cMensagem, "Teste 2 IsDrive")

    FWRestArea(aArea)
Return
