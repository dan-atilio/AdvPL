/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/05/abrindo-uma-tela-mvc-com-fwexecview-maratona-advpl-e-tl-216/
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "FWMVCDef.ch"

/*/{Protheus.doc} User Function zExe216
Exemplo de função que abre uma tela em MVC
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWExecView
@obs 

    Função FWExecView
    Parâmetros
        + cTitulo        , Caractere       , Título da Janela
        + cPrograma      , Caractere       , Nome do programa em MVC
        + nOperation     , Numérico        , Indica a operação se é inclusão (3); alteração (4) ou exclusão (5)
        + oDlg           , Objeto          , Parâmetro descontinuado
        + bCloseOnOK     , Bloco de Código , Bloco de código acionado no fechamento da janela
        + bOk            , Bloco de Código , Bloco de código acionado na validação ao clicar em Confirmar
        + nPercReducao   , Numérico        , Percentual de redução do tamanho da Janela
        + aEnableButtons , Array           , Botões que serão habilitados na Janela
        + bCancel        , Bloco de Código , Bloco de código na validação ao clicar em Cancelar / Fechar
        + cOperatId      , Caractere       , Identificação da operação (usado quando tem mais de um 4 no nOperation no programa MVC)
        + cToolBar       , Caractere       , Indica o relacionamento dos botões com a tela
        + oModelAct      , Objeto          , Model instanciado que será usado pela View
    Retorno
        + nValor        , Numérico  , 0 se foi clicado em Ok e 1 se foi clicado em Cancelar

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe216()
    Local aArea := FWGetArea()
    Local cFunBkp := FunName()
     
    DbSelectArea('SA2')
    SA2->(DbSetOrder(1)) //Filial + Código + Loja
     
    //Se conseguir posicionar
    If SA2->(DbSeek(FWxFilial('SA2') + "F00002"))
        SetFunName("MATA020")
        FWExecView('Visualizacao Teste', 'MATA020', MODEL_OPERATION_VIEW)
        SetFunName(cFunBkp)
    EndIf

    FWRestArea(aArea)
Return
