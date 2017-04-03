//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zUsrFil
Função que valida se o usuário tem acesso a filial
@author Atilio
@since 20/01/2017
@version undefined
@type function
	@param cCodUsr, characters, Código do usuário pesquisado (por default, vem o código do usuário logado)
	@param cCodEmp, characters, Código da empresa / grupo de empresas (por default, vem o código da empresa / grupo atual)
	@param cCodFil, characters, Código da filial (por default, vem o código da filial atual)
	@example u_zUsrFil("000001", "01", "02")
	u_zUsrFil("000001", "01", "0201")
	@obs Função desenvolvida com ajuda de Gabriel Cisneiro
/*/

User Function zUsrFil(cCodUsr, cCodEmp, cCodFil)
	Local lRet      := .F.
	Local aUsuarios := AllUsers()
	Local aUsrAux   := {}
	Local nLinEnc   := 0
	Local nPosFil   := 0
	Default cCodUsr := RetCodUsr()
	Default cCodEmp := cEmpAnt
	Default cCodFil := cFilAnt
	
	//Encontra o usuário
	nLinEnc:= aScan(aUsuarios, {|x| x[1][1] == cCodUsr })
	
	//Caso encontre o usuário
	If nLinEnc > 0
		aUsrAux := aClone(aUsuarios[nLinEnc][2][6])
		
		//Agora procura pela empresa + filial nos acessos 
		nPosFil := aScan(aUsrAux, {|x| x == cCodEmp + cCodFil })
		
		//Se encontrou a filial ou tem acesso a todas, o retorno será verdadeiro
		If nPosFil > 0 .Or. "@" $ aUsrAux[1]
			lRet := .T.
		EndIf
	EndIf
	
Return lRet