/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/15/disparando-uma-execucao-automatica-atraves-da-fwmvcrotauto-maratona-advpl-e-tl-237/
*/


//Bibliotecas
#Include 'TOTVS.ch'
#Include 'FWMVCDef.ch'
 
/*/{Protheus.doc} User Function zExe237
Aciona uma operação automática em MVC
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWMVCRotAuto
@obs 
    Função FWMVCRotAuto
    Parâmetros
        + oModel        , Objeto            , Objeto com o modelo do formulário
        + cAlias        , Caractere         , Alias do Browse
        + nOpcAuto      , Numérico          , Número da operação sendo 3 = inclusão ; 4 = alteração e 5 = exclusão
        + aAuto         , Array             , Array com os campos e conteúdos
        + lSeek         , Lógico            , Indica se o registro deve ser posicionado (se for uma alteração ou exclusão)
        + lPosaRot      , Lógico            , Indica se o nOpc não deve ser calculado com base no aRotina
    Retorno
        + lRetorno      , Lógico            , .T. se a operação foi bem sucedida ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe237()
	Local aArea         := GetArea()
    Local aDados        := {}
    Private aRotina     := FWLoadMenuDef("MATA020")
    Private oModel      := FWLoadModel("MATA020")
    Private lMsErroAuto := .F.
     
    //Adicionando os dados do ExecAuto
    aAdd(aDados, {"A2_COD",      "F0004",         Nil})
    aAdd(aDados, {"A2_LOJA",     "01",            Nil})
    aAdd(aDados, {"A2_NOME",     "Teste",         Nil})
    aAdd(aDados, {"A2_NREDUZ",   "Tst",           Nil})
    aAdd(aDados, {"A2_TIPO",     "F",             Nil})
    aAdd(aDados, {"A2_END",      "Rua de teste",  Nil})
    aAdd(aDados, {"A2_EST",      "SP",            Nil})
    aAdd(aDados, {"A2_COD_MUN",  "06003",         Nil})
    aAdd(aDados, {"A2_HPAGE",    "tst.com",       Nil})
    aAdd(aDados, {"A2_EMAIL",    "teste@tst.com", Nil})
    aAdd(aDados, {"A2_NATUREZ",  "NATREC0001",    Nil})
     
    //Chamando a inclusão - Modelo 1
    lMsErroAuto := .F.
    FWMVCRotAuto( ;
        oModel,;                        //Modelo
        "SA2",;                         //Alias
        MODEL_OPERATION_INSERT,;        //Operacao
        {{"SA2MASTER", aDados}};        //Dados
    )

    //Se tiver mais de um Form, deve se passar dessa forma:
    // {{"ZZ2MASTER", aAutoCab}, {"ZZ3DETAIL", aAutoItens}})
     
    //Se houve erro no ExecAuto, mostra mensagem
    If lMsErroAuto
        MostraErro()
     
    //Senão, mostra uma mensagem de inclusão    
    Else
        MsgInfo("Registro incluido!", "Atenção")
    EndIf
     
    RestArea(aArea)
Return
