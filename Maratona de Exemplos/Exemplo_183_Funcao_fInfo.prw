/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/19/valida-se-um-campo-existe-retornando-o-nome-dele-atraves-da-finextcpo-maratona-advpl-e-tl-182/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe183
Carrega um array com os dados da filial passada por parâmetro
@type Function
@author Atilio
@since 21/12/2022
@obs 
    Função fInfo
    Parâmetros
        + Array que terá as informações (as posições estão descritas mais abaixo)
        + Código da filial (se não passar nada pega da filial logada)
        + Código da empresa (se não passar nada pega da empresa logada)
    Retorno
        + .T. se encontrou a empresa e filial ou .F. se não encontrou

    Posições do Array:
    [01] = Filial
    [02] = Nome Reduzido
    [03] = Nome Completo
    [04] = Endereco Cobranca
    [05] = Cidade Cobranca
    [06] = Estado Cobranca
    [07] = Cep Cobranca
    [08] = Cgc Cobranca
    [09] = Insc Cobranca
    [10] = Telefone
    [11] = Fax 
    [12] = Producao Rural
    [13] = Bairro Cobranca 
    [14] = Compl. End. Cobranca
    [15] = Tipo de Inscricao
    [16] = CNAE
    [17] = FPAS
    [18] = Acid. de Trabalho
    [19] = Codigo Municipio
    [20] = Natureza Juridica
    [21] = Data Base Pgto. RAIS
    [22] = Numero de Proprietarios
    [23] = Se Modificou Endereco
    [24] = Se Modificou INSC/CGC
    [25] = Causa da Mudanca
    [26] = INC./CGC Anterior
    [27] = CEI
    [28] = Tipo da Inscricao

    *** Os dados (como endereço) serão de cobrança ou entrega dependendo do parâmetro MV_PAREND
    *** Existe um ponto de entrada que é possível manipular o array, antes de retornar a função que é o GPEXINSCR

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe183()
    Local aArea     := FWGetArea()
    Local aDados    := {}

    //Carrega os dados da empresa e filial logada
    If fInfo(@aDados)

        //Mostra a mensagem
        FWAlertInfo("Nome da empresa: " + aDados[2], "Teste de fInfo")
    EndIf

    FWRestArea(aArea)
Return
