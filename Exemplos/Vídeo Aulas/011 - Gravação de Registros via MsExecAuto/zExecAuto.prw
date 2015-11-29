//Bibliotecas
#Include "Protheus.ch"
#Include "RwMake.ch"
#Include "TBIConn.ch"

/*/{Protheus.doc} zExecAuto
Exemplo de gravação via ExecAuto
@author Atilio
@since 29/11/2015
@version 1.0
	@example
	u_zExecAuto()
/*/

User Function zExecAuto()
	Local aArea	:= GetArea()
	Local aVetor	:= {}
	//Variáveis utilizadas pelo ExecAuto (caso queira gravar o log em arquivo texto, utilize as duas variáveis abaixo
	/*Private lMSHelpAuto		:= .T.
	Private lAutoErrNoFile	:= .T.*/
	Private lMsErroAuto		:= .F.
	
	//Adicionando dados no produto para testar inclusão
	aVetor :=	{;
					{"B1_COD",			"99999Z",									Nil},;
					{"B1_DESC",		"PRODUTO TESTE - ROTINA AUTOMATICA",	Nil},;
					{"B1_TIPO",		"P+",										Nil},;
					{"B1_UM",			"UN",										Nil},;
					{"B1_LOCPAD",		"01",										Nil},;
					{"B1_PICM",		0,											Nil},;
					{"B1_IPI",			0,											Nil},;
					{"B1_CONTRAT",	"N",										Nil},;
					{"B1_LOCALIZ",	"N",										Nil};
				}
	
	//Iniciando controle de transação
	Begin Transaction
		//Chamando o cadastro de produtos de forma automática
		MSExecAuto({|x,y| Mata010(x,y)},aVetor,3)
		
		//Se houve erro
		If lMsErroAuto
			//Caso queira gravar o log em arquivo texto, não se deve usar a rotina MostraErro, mas sim o trecho abaixo:
			/*
			aLogAuto	:= {}
			cLogTxt	:= ""
			
			//Pegando log do ExecAuto
			aLogAuto := GetAutoGRLog()
			
			//Percorrendo o Log
			For nAux:=1 To Len(aLogAuto)
				cLogTxt += aLogAuto[nAux] + Chr(13)+Chr(10)
			Next
			*/
		
			//Mostrando a janela de erro
			MostraErro()
			
			//Disarmando a transação
			DisarmTransaction()
		EndIf
	             
	End Transaction

	RestArea(aArea)
Return