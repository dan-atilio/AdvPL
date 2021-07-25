/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/03/23/como-substituir-o-conout-pelo-fwlogmsg/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zConOut
Função para substituir o ConOut (por causa do Code Analysis)
@type  Function
@author Atilio
@since 24/06/2021
@version version
@param cTexto, Caractere, Texto a ser exibido no console.log
@example
    u_zConOut("Teste")
@obs Para ativar esse recurso, a chave FWLogMsg_Debug tem que estar como 1 no AppServer.ini:
    https://centraldeatendimento.totvs.com/hc/pt-br/articles/360041301114-MP-ADVPL-Como-Ativar-a-fun%C3%A7%C3%A3o-FWLogMsg-
@see https://tdn.totvs.com/display/framework/FWLogMsg
/*/

User Function zConOut(cTexto)
    Local aArea    := GetArea()
	Default cTexto := ""
	
    FWLogMsg(;
		"INFO",;    //cSeverity      - Informe a severidade da mensagem de log. As opções possíveis são: INFO, WARN, ERROR, FATAL, DEBUG
		,;          //cTransactionId - Informe o Id de identificação da transação para operações correlatas. Informe "LAST" para o sistema assumir o mesmo id anterior
		"ZCONOUT",; //cGroup         - Informe o Id do agrupador de mensagem de Log
		,;          //cCategory      - Informe o Id da categoria da mensagem
		,;          //cStep          - Informe o Id do passo da mensagem
		,;          //cMsgId         - Informe o Id do código da mensagem
		cTexto,;    //cMessage       - Informe a mensagem de log. Limitada à 10K
		,;          //nMensure       - Informe a uma unidade de medida da mensagem
		,;          //nElapseTime    - Informe o tempo decorrido da transação
		;           //aMessage       - Informe a mensagem de log em formato de Array - Ex: { {"Chave" ,"Valor"} }
	) 
	
	RestArea(aArea)
Return
