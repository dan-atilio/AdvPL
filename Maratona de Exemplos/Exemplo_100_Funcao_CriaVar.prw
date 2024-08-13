/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/11/16/criando-variaveis-conforme-definicoes-do-dicionario-usando-a-criavar-maratona-advpl-e-tl-100/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe100
Cria uma variável conforme as parametrizações do dicionário de dados
@type Function
@author Atilio
@since 11/12/2022
@obs 
    Função CriaVar
    Parâmetros
        + Nome do campo
        + Se deverá ser considerado o inic. padrão do campo
        + Indica se deve adicionar espacos a esquerda (L); direita (R); ou centralizado (C)
        + Cria como variável pública na memória (somente para campos que sejam virtuais no X3_CONTEXT)
    Retorno
        + Retorna o conteúdo do campo a ser colocado na variável

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe100()
    Local aArea     := FWGetArea()
    Local dDtCad
    Local cHrCad

    //Inicializa as variáveis conforme o conteúdo do inic. padrão dos campos
    dDtCad := CriaVar("A1_DTCAD")
    cHrCad := CriaVar("A1_HRCAD")

    //Mostra uma mensagem
    FWAlertInfo("Data = " + dToC(dDtCad) + " e Hora = " + cHrCad, "Teste CriaVar")

    FWRestArea(aArea)
Return
