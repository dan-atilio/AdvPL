/*/{Protheus.doc} zInicio1
Função executada no Programa Inicial, sem precisar usuário e senha
@type function
@author Atilio
@since 03/10/2016
@version 1.0
	@example
	u_zInicio1()
/*/

User Function zInicio1()
	//Cria o MsApp
	MsApp():New('SIGATST') 
	oApp:CreateEnv()
	
	//Seta o tema do Protheus (SUNSET = Vermelho; OCEAN = Azul)
	PtSetTheme("SUNSET")
	
	//Define o programa de inicialização 
	oApp:bMainInit:= {|| MsgRun("Configurando ambiente...","Aguarde...",;
		{|| RpcSetEnv("99","01"), }),;
		MATA010(),;
		Final("TERMINO NORMAL")}
	
	//Seta Atributos 
	__lInternet := .T.
	lMsFinalAuto := .F.
	oApp:lMessageBar:= .T. 
	oApp:cModDesc:= 'SIGATST'
	
	//Inicia a Janela 
	oApp:Activate()
Return Nil

/*/{Protheus.doc} zInicio2
Função executada no Programa Inicial, utilizando login
@type function
@author Atilio
@since 03/10/2016
@version 1.0
	@example
	u_zInicio2()
/*/

User Function zInicio2()
	//Cria o MsApp
	MsApp():New('SIGACOM')
	oApp:CreateEnv()
	
	//Seta o tema do Protheus (SUNSET = Vermelho; OCEAN = Azul)
	PtSetTheme("OCEAN")
	
	//Define o programa que será executado após o login
	oApp:cStartProg	:= 'MATA010'
	
	//Seta Atributos 
	__lInternet := .T.
	
	//Inicia a Janela 
	oApp:Activate()
Return Nil