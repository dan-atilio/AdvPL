/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/14/somando-meses-em-uma-determinada-data-com-a-monthsum-maratona-advpl-e-tl-354/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe355
Exibe uma tela com as mensagens de falha de uma operação automática
@type Function
@author Atilio
@since 26/03/2023
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815088
@obs 
    Função MostraErro
    Parâmetros
        + cPath    , Caractere    , Indica a pasta que o log será gravado
        + cNome    , Caractere    , Indica o nome do arquivo
    Retorno
        Função não tem Retorno

    Obs.: Caso os arquivos cPath e cNome não forem informados, será exibido uma tela com o que pode ter ocasionado o erro

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe355()
    Local aArea         := FWGetArea()
    Local aDados        := {}
    Private lMsErroAuto := .F.

    //Adiciona os campos
    aAdd(aDados, {"B1_COD",    "F0001",   Nil})
    aAdd(aDados, {"B1_DESC",   "Teste",   Nil})
    aAdd(aDados, {"B1_TIPO",   "PA",      Nil})
    aAdd(aDados, {"B1_UM",     "KG",      Nil})
    aAdd(aDados, {"B1_LOCPAD", "01",      Nil})
    aAdd(aDados, {"B1_GRUPO",  "G001",    Nil})

    //Chama a inclusão
    MsExecAuto({|x, y| MATA010(x, y)}, aDados, 3)

    //Se houve erro, mostra a mensagem
    If lMsErroAuto
        MostraErro()
    EndIf

    FWRestArea(aArea)
Return
