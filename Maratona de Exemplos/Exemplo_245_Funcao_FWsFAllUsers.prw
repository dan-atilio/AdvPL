/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/19/fazendo-um-backup-das-linhas-de-grids-em-mvc-com-fwsaverows-e-fwrestrows-maratona-advpl-e-tl-244/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe245
Função que busca todos os usuários cadastrados
@type  Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/PROT/FWSFALLUSERS
@obs 
    Função FWsFAllUsers
    Parâmetros
        + aUserList   , Array    , Informa a lista de usuários
        + aKeyValues  , Array    , Lista com os campos que serão retornados
        + Reservado
        + Reservado
        + lBlock      , Lógico   , Retorna informação de usuários bloqueados
    Retorno
        + aUsers      , Array    , Array com as seguintes posições [1] Id da tabela de usuários (r_e_c_n_o_) ; [2] Id do usuário ; [3] Login do Usuário ; [4] Nome do usuário ; [5] email do usuário ; [6] departamento do usuário ; [7] cargo do usuário
    
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe245()
    Local aArea      := FWGetArea()
    Local lAcessa    := .F.
	Local cUsrLogad  := RetCodUsr()
	Local aTodosUsr  := FWSfAllUsers()
	Local nEncontrou := 0
    Local aGrupos    := {}
	Local nGrupoAtu  := 0
    Local aEmpFil    := {}

    //Se for admin, ele tem acesso a empresa e filial
	If FWIsAdmin()
		lAcessa := .T.
	Else
        //Efetua a busca pelo usuário logado
		nEncontrou:= aScan(aTodosUsr,{|x| x[2] == cUsrLogad })

        //Se encontrou o usuário
		If nEncontrou > 0
            //Busca todos os grupos que o usuário tem acesso
			aGrupos := FWSFUsrGrps(cUsrLogad)

            //Percorre os grupos
			For nGrupoAtu := 1 To Len(aGrupos)

                //Busca empresa e filial que o grupo tem acesso
				aEmpFil := FWGrpEmp(aGrupos[nGrupoAtu])

                //Se veio dados
				If Len(aEmpFil) > 0 

                    //Caso seja um arroba ou tiver a empresa e filial logadas, o usuário tem acesso
					If "@" $ aEmpFil[1] .Or. aEmpFil[1] == cEmpAnt + cFilAnt
						lAcessa := .T.
                        Exit
					EndIf
				EndIf
			Next
		endif
	EndIf

    If lAcessa
        FWAlertSuccess("Usuário possui acesso!", "Teste FWSfAllUsers")
    EndIf

    FWRestArea(aArea)
Return
