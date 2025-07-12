/*
    
    Esse � um exemplo disponibilizado no Terminal de Informa��o 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/07/03/como-gravar-um-log-das-rotinas-e-modulos-mais-usados-ti-responde-0165/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function ChkExec
Ponto de Entrada acionado ao clicar em alguma op��o no menu
@type  Function
@author Atilio
@since 12/06/2024
@see https://tdn.totvs.com/display/public/framework/CHKEXEC+-+Dispara+ponto+de+entrada
/*/

User Function ChkExec()
    Local aArea     := FWGetArea()
    Local lContinua := .T.
    Local cFuncao   := ParamIXB

    //Se veio par�nteses, tira
    If "(" $ cFuncao
        cFuncao := Left(cFuncao, At("(", cFuncao) - 1)
    EndIf

    //Aciona a rotina para criar o log
    If ExisteSX2("ZL0")
        u_zVid0165(cFuncao)
    EndIf

    FWRestArea(aArea)
Return lContinua

/*/{Protheus.doc} User Function zVid0165
Fun��o para gravar um log quando um usu�rio acessa alguma rotina, pode ser adicionada em pontos de entrada como SDULogin ou ChkExec
@type  Function
@author Atilio
@since 12/06/2024
@param cFuncao, Caractere, Nome da fun��o
@obs � necess�rio criar uma tabela no Configurador, no nosso exemplo usamos a ZL0, sendo:

Tabela:
    ZL0 - Logs de Acesso em Fun��es (pode ser compartilhada ou exclusiva, depende da sua regra de neg�cio)

Campos (todos com Contexto Real):
    ZL0_FILIAL - Campo padr�o
    ZL0_CODIGO - C�digo Sequencial - Caractere - Tamanho 9
    ZL0_USRCOD - C�digo do Usu�rio - Caractere - Tamanho 6
    ZL0_USRNOM - Nome do Usu�rio   - Caractere - Tamanho 30
    ZL0_AMBIEN - Ambiente          - Caractere - Tamanho 30
    ZL0_DATA   - Data              - Data      - Tamanho 8
    ZL0_HORA   - Hora              - Caractere - Tamanho 8
    ZL0_FUNCAO - Nome da Fun��o    - Caractere - Tamanho 20
    ZL0_MODNUM - N�mero do M�dulo  - Num�rico  - Tamanho 2
    ZL0_MODSIG - Sigla do M�dulo   - Caractere - Tamanho 3

�ndices:
    1: ZL0_FILIAL + ZL0_CODIGO

/*/

User Function zVid0165(cFuncao)
    Local aArea     := FWGetArea()
    Local cCodUsr   := RetCodUsr()
    Local cCodSeq   := ""
    Default cFuncao := FunName()

    //Busca o pr�ximo sequencial
    DbSelectArea("ZL0")
    cCodSeq   := GetSXENum("ZL0", "ZL0_CODIGO")

    //Inclui o registro na tabela de logs
    RecLock("ZL0", .T.)
        ZL0->ZL0_FILIAL := FWxFilial("ZL0")
        ZL0->ZL0_CODIGO := cCodSeq                //C�digo sequencial
        ZL0->ZL0_USRCOD := cCodUsr                //C�digo do Usu�rio
        ZL0->ZL0_USRNOM := UsrRetName(cCodUsr)    //Nome do Usu�rio
        ZL0->ZL0_AMBIEN := GetEnvServer()         //Ambiente
        ZL0->ZL0_DATA   := Date()                 //Data
        ZL0->ZL0_HORA   := Time()                 //Hora
        ZL0->ZL0_FUNCAO := cFuncao                //Nome da Fun��o
        ZL0->ZL0_MODNUM := nModulo                //N�mero do M�dulo
        ZL0->ZL0_MODSIG := cModulo                //Sigla do M�dulo
    ZL0->(MsUnlock())
    ConfirmSX8()

    FWRestArea(aArea)
Return
