/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/02/validando-valores-com-a-funcao-positivo-maratona-advpl-e-tl-391/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zExe391
Verifica se um valor é positivo
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=24347027
@obs 

    Função Positivo
    Parâmetros
        Valor que será validado (se não for informado pega o conteúdo do campo digitado em memória)
    Retorno
        Retorna .T. se é positivo ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe391()
    Local aArea    := FWGetArea()
    Local nValor   := 0
 
    //Faz a validação de um valor negativo
    nValor := -5
    If Positivo(nValor)
        FWAlertSuccess("O valor é positivo!", "Teste 1 Positivo")
    EndIf

    //Faz a validação de um valor positivo
    nValor := 60
    If Positivo(nValor)
        FWAlertSuccess("O valor é positivo!", "Teste 2 Positivo")
    EndIf
 
    FWRestArea(aArea)
Return
