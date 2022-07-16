//Bibliotecas
#Include "Totvs.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} A010TOK
Ponto de entrada, na validação do botão confirmar no cadastro de Produtos
@author Atilio
@since 08/03/2022
@version 1.0
@type function
/*/

User Function A010TOK()
	Local aArea    := FWGetArea()
	Local aAreaSB1 := SB1->(FWGetArea())
	Local lRet     := .T.
	Local cGrupo   := M->B1_GRUPO
    Local cTipo    := M->B1_TIPO

    //Se for produto Acabado
    If cTipo == "PA"
        //Se o Grupo for o 3, não permite continuar
        If cGrupo == "0003"
            lRet := .F.

            //Se usar assim, será mostrado uma mensagem vazia pois a tela é em MVC
            //MsgStop("O grupo [" + cGrupo + "] não pode ser usado para produtos do tipo [" + cTipo + "]!", "Atenção")

            //O certo é usar a função Help
            Help(, , "Help", , "Cadastro Inválido!", 1, 0, , , , , , {"O grupo [" + cGrupo + "] não pode ser usado para produtos do tipo [" + cTipo + "]!"})
        EndIf
    EndIf

	FWRestArea(aAreaSB1)
	FWRestArea(aArea)
Return lRet
