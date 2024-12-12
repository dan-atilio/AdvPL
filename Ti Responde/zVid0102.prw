/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/11/26/como-fazer-um-browse-listar-registros-excluidos-ti-responde-0102/ 
    
*/


//Bibliotecas
#Include "Totvs.ch"

/*/{Protheus.doc} User Function ChkExec
Ponto de Entrada acionado ao clicar em alguma opção no menu
@type  Function
@author Atilio
@since 04/03/2024
@see https://tdn.totvs.com/display/public/framework/CHKEXEC+-+Dispara+ponto+de+entrada
/*/

User Function ChkExec()
    Local lContinua := .T.

    //Aciona a customização antes de abrir a tela
    u_zVid0102()

Return lContinua

/*/{Protheus.doc} User Function zVid0102
Função customizada para habilitar a visualização de registros apagados, somente se o usuário logado for administrador
@type  Function
@author Atilio
@since 04/03/2024
@see https://tdn.totvs.com/display/tec/Fundamentos+do+ISAM
/*/

User Function zVid0102()
    
    //Somente se for usuário administrador e não tiver em processo automático sem tela
    If FWIsAdmin() .And. ! IsBlind()
        
        //Mostra a pergunta, se ele quer trazer registros deletados
        If FWAlertYesNo("Deseja exibir registros apagados (campo D_E_L_E_T_ igual à asterisco)?", "Confirma?")
            SET DELETED OFF
        EndIf
    EndIf

Return
