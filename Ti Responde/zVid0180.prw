/*
    
    Esse � um exemplo disponibilizado no Terminal de Informa��o 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/08/26/como-fazer-para-que-a-senha-de-um-usuario-nunca-expire-no-protheus-ti-responde-0180/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "FWMVCDef.ch"
 
/*/{Protheus.doc} User Function zAtuSenha
Fun��o para resetar senha de usu�rios
@type  Function
@author Atilio
@since 02/06/2022
@see https://terminaldeinformacao.com/2023/11/17/conheca-brechas-de-seguranca-do-protheus-e-como-preveni-las/
/*/
 
User Function zAtuSenha(cLoginUsr, cSenhaUsr)
    Local cAliasUsr := "MPUSR_USR"
    Local lDeuCerto := .F.
 
    //Abre a tabela de usu�rios e posiciona
    DbSelectArea(cAliasUsr)
    (cAliasUsr)->(DbSetOrder(2)) // USR_CODIGO
     
    If (cAliasUsr)->(MsSeek(cLoginUsr))

        QOut("[RESET USER][B01] Encontrou o Login")
 
        //Se n�o usar o filtro ou tentar usar DbSetFilter no lugar de Set Filter To, ocasiona erro atualizando sempre o primeiro registro
        Set Filter To &("USR_CODIGO = '" + cLoginUsr + "'")
 
        //Ativa o modelo como altera��o (CFGA510)
        oModel := FWLoadModel("FWUSERACCOUNTDATA")
        oModel:SetOperation(MODEL_OPERATION_UPDATE)
        oModel:Activate()
 
        //Define o campo de senha (nome do campo real � USR_SENHA, mas no model � os abaixo)
        oModel:SetValue("DATAUSER", "USR_PSW",    cSenhaUsr)
        oModel:SetValue("DATAUSER", "USR_PSWCMP", cSenhaUsr)

        QOut("[RESET USER][B02] Ap�s setar o user")
 
        //Se conseguir validar os dados e realizar o commit
        If oModel:VldData() .And. oModel:CommitData()
            lDeuCerto := .T.

            QOut("[RESET USER][B03] Deu certo a altera��o")
 
        //Se n�o, houve erro, incrementa a mensagem
        Else
            //Busca o Erro do Modelo de Dados
            aErro := oModel:GetErrorMessage()
 
            //Monta o Texto que ser� mostrado na tela
            AutoGrLog("Id do formul�rio de origem:"  + ' [' + AllToChar(aErro[01]) + ']')
            AutoGrLog("Id do campo de origem: "      + ' [' + AllToChar(aErro[02]) + ']')
            AutoGrLog("Id do formul�rio de erro: "   + ' [' + AllToChar(aErro[03]) + ']')
            AutoGrLog("Id do campo de erro: "        + ' [' + AllToChar(aErro[04]) + ']')
            AutoGrLog("Id do erro: "                 + ' [' + AllToChar(aErro[05]) + ']')
            AutoGrLog("Mensagem do erro: "           + ' [' + AllToChar(aErro[06]) + ']')
            AutoGrLog("Mensagem da solu��o: "        + ' [' + AllToChar(aErro[07]) + ']')
            AutoGrLog("Valor atribu�do: "            + ' [' + AllToChar(aErro[08]) + ']')
            AutoGrLog("Valor anterior: "             + ' [' + AllToChar(aErro[09]) + ']')
 
            //Mostra a mensagem de Erro
            MostraErro()

            QOut("[RESET USER][B04] Falha na atualiza��o: " + aErro[06])
        EndIf
 
        //Desativa o modelo da mem�ria
        oModel:DeActivate()
        FreeObj(oModel)
 
        DbSelectArea(cAliasUsr)
        Set Filter To
        QOut("[RESET USER][B05] Ap�s limpar filtro")
    EndIf
Return lDeuCerto
 
 
/*/{Protheus.doc} User Function zVid0180
Fun��o para resetar o usu�rio para n�o expirar a senha (agendar no Schedule para rodar todo dia)
@type  Function
@author Atilio
@since 01/07/2024
/*/
 
User Function zVid0180()
    Local cLogin     := "daniel.atilio"
    Local cPass      := Decode64("dHN0MTIz")
    Local cEmpresAux := "99"
    Local cFilialAux := "01"

    If Select("SX2") <= 0
        RPCSetEnv(cEmpresAux, cFilialAux, cLogin, cPass, "", "")
    EndIf

    QOut("[RESET USER][A01] Antes do zAtuSenha")
 
    u_zAtuSenha(cLogin, cPass)

    QOut("[RESET USER][A02] Depois do zAtuSenha")
 
Return
