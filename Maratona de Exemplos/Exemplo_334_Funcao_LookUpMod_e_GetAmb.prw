/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/04/consultando-os-modulos-do-sistema-com-lookupmod-e-getamb-maratona-advpl-e-tl-334/
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExe334
Abre a consulta de módulos do produtos (compras, estoque, faturamento, etc)
@type Function
@author Atilio
@since 12/03/2023
@obs 

    Função LookUpMod
    Parâmetros
        Não tem parâmetros
    Retorno
        Retorna .T. se a janela foi confirmada ou .F. se não

    Função GetAmb
    Parâmetros
        Recebe se deve retornar o código ("1") ou a descrição ("2") do módulo selecionado
    Retorno
        Retorna o texto conforme o parâmetro informado

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe334()
    Local aArea     := FWGetArea()
    Local cMensagem := ""

    //Se a pergunta de módulos foi confirmada
    If LookUpMod()
        //Monta a mensagem e exibe
        cMensagem := "Codigo: " + GetAmb("1") + CRLF
        cMensagem += "Descricao: " + GetAmb("2")
        FWAlertInfo(cMensagem, "Teste LookUpMod e GetAmb")
    EndIf

    FWRestArea(aArea)
Return
