/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/20/buscando-informacoes-das-empresas-atraves-da-fwsm0util-maratona-advpl-e-tl-247/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe246
Classe para buscar informações da SIX (Índices)
@type  Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWSIXUtil
@obs 
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe246()
    Local aArea      := FWGetArea()
    Local aIndices   := {}

    //Busca os índices da SB1
    aIndices := FWSIXUtil():GetAliasIndexes("SB1") 

    //Exibe uma mensagem
    FWAlertInfo("Foi encontrado " + cValToChar(Len(aIndices)) + " índice(s)", "Teste FWSIXUtil")

    FWRestArea(aArea)
Return
