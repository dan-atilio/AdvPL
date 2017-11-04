//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zMataTudo
Função que mata todas as conexões ativas do Protheus
@author Atilio
@since 21/09/2017
@version 1.0
@type function
@obs Documentação no TDN
	GetUserInfoArray - http://tdn.totvs.com/display/tec/GetUserInfoArray
	KillUser         - http://tdn.totvs.com/display/tec/KillUser
/*/

User Function zMataTudo()
	Local aArea      := GetArea()
	Local aThreads   := {}
	Local nConexAtu  := 1
	Local nTentativa := 1
	Local nMaxTenta  := 10
	
	//Se não tiver preparado o ambiente (Schedule)
	If Select("SX2") == 0
		RPCSetType(3)
		RPCSetEnv("01", "01", "", "", "")
	EndIf
	
	ConOut("[zMataTudo] Inicio - " + dToC(Date()) + " " + Time())
	
	//Pega todos os usuários conectados
	aThreads := GetUserInfoArray()
	
	//Enquanto houver tentativas para finalizar as threads
	While nTentativa <= nMaxTenta
		//Percorre todas as conexões
		For nConexAtu := 1 To Len(aThreads)
			
			//Se a thread da conexão atual for diferente da thread atual (senão vai matar o processo que mata todos)
			If aThreads[nConexAtu][3] != ThreadId()
				KillUser( aThreads[nConexAtu][1],; //UserName
				          aThreads[nConexAtu][2],; //ComputerName
				          aThreads[nConexAtu][3],; //ThreadId
				          aThreads[nConexAtu][4])  //ServerName
				
				ConOut("[zMataTudo] "+;
				       "(Tentativa "+cValToChar(nTentativa)+") " + ;
				       "Usuario '"+Alltrim(aThreads[nConexAtu][1])+"', " + ;
				       "Server '"+aThreads[nConexAtu][4]+"', " + ;
				       "Thread '"+cValToChar(aThreads[nConexAtu][3])+"', " + ;
				       "Tempo Total de Conexão '"+aThreads[nConexAtu][8]+"' ")
			EndIf
		Next
		
		//Pega novamente todos os usuários conectados
		aThreads := GetUserInfoArray()
		
		//Se ainda houver registros, aumenta a tentativa e espera 1 segundo
		If Len(aThreads) > 1
			nTentativa++
			Sleep(1000)
			
		//Senão finaliza o laço de repetição
		Else
			Exit
		EndIf
	EndDo
	
	ConOut("[zMataTudo] Termino - " + dToC(Date()) + " " + Time())
	
	RestArea(aArea)
Return