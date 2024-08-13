/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/29/buscando-a-mascara-de-um-campo-com-as-pesqpict-e-x3picture-maratona-advpl-e-tl-385/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe384
Verifica se um valor pertence a outro
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=24347025
@obs 

    Função Pertence
    Parâmetros
        String com os valores possíveis
        String com o valor que será validado (se não for informado pega o conteúdo do campo digitado em memória)
    Retorno
        Retorna .T. se pertence ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe384()
    Local aArea    := FWGetArea()
 
    //Valida se a expressão da direta, pertence a expressão da esquerda
    If Pertence("ABCDE", "A")
        FWAlertSuccess("O valor foi encontrado na busca!", "Teste - Pertence")
    EndIf
 
    FWRestArea(aArea)
Return
