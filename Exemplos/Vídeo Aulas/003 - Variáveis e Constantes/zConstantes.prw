/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/10/19/vd-advpl-003/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"

//Se for espanhol
#Ifdef SPANISH
	#Define STR_TESTE		'Un gran poder conlleva una gran responsabilidad.'
	#Define STR_TITULO	'Precaución'
	
//Senão, irá fazer outros testes
#Else
	//Se for em Inglês
	#Ifdef ENGLISH
		#Define STR_TESTE		'With great power comes great responsibility.'
		#Define STR_TITULO	'Caution'
		
	//Senão, será o padrão (Português)
	#Else
		#Define STR_TESTE		'Com grandes poderes vêm grandes responsabilidades.'
		#Define STR_TITULO	'Atenção'
	#EndIf
#EndIf

//Constantes
#Define STR_PULA		Chr(13)+Chr(10)

/*/{Protheus.doc} zConstantes
Exemplo de teste com diretivas / constantes
@author Atilio
@since 13/10/2015
@version 1.0
	@example
	u_zConstantes()
/*/

User Function zConstantes()
	Local aArea := GetArea()
	
	//Mostrando mensagem
	MsgAlert(STR_TESTE + STR_PULA + "...", STR_TITULO)
	
	RestArea(aArea)
Return