/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/18/consumindo-um-webservice-atraves-da-fwrest-maratona-advpl-e-tl-242/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe243
Função que retorna o idioma usado
@type  Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FwRetIdiom
@obs 
    Função FWRetIdiom
    Parâmetros
        Não tem parâmetros
    Retorno
        Retorna a string com o idioma
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe243()
    Local aArea         := FWGetArea()
    Local cIdioma       := ""

    //Busca o idioma e exibe a mensagem
    cIdioma := FWRetIdiom()
    FWAlertInfo(cIdioma, "Teste FWRetIdiom")

    FWRestArea(aArea)
Return
