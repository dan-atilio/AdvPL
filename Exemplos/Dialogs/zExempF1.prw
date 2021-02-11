/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/10/29/como-colocar-um-help-em-um-get-customizado-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

//Bibliotecas
#Define STR_PULA	Chr(13)+Chr(10)

/*/{Protheus.doc} zExempF1
Exemplo de help (F1) em Gets customizados
@type function
@author Atilio
@since 27/10/2015
@version 1.0
	@example
	u_zExempF1()
/*/

User Function zExempF1()
	Local aArea := GetArea()
	//Dimensões da janela
	Local nJanAltu := 080
	Local nJanLarg := 220
	//Objetos da janela
	Private oSayNor, oGetNor, cGetNor := Space(10)
	Private oSayBD,  oGetBD,  cGetBD  := Space(10)
	Private oDlgPvt
	
	//Criando a janela
	DEFINE MSDIALOG oDlgPvt TITLE "Janela" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
		//Get Normal
		@ 006, 006 SAY        oSayNor PROMPT "Normal:"                  SIZE 050, 007 OF oDlgPvt PIXEL
		@ 003, 060 MSGET      oGetNor VAR    cGetNor                    SIZE 040, 010 OF oDlgPvt PIXEL
		oGetNor:bHelp := {||	ShowHelpCpo(	"cGetNor",;
								{"Texto Linha 1"+STR_PULA+"Texto Linha 2"},2,;
								{"Solução Linha 1"},2)}
								
		//Get Banco
		@ 026, 006 SAY        oSayBD  PROMPT "BD:"                      SIZE 050, 007 OF oDlgPvt PIXEL
		@ 023, 060 MSGET      oGetBD  VAR    cGetBD                     SIZE 040, 010 OF oDlgPvt PIXEL
		oGetBD:bHelp := {||	ShowHelpCpo(	"cGetBD",;
								{GetHlpSoluc("B1_COD")[1]},2,;
								{GetHlpSoluc("B1_COD")[2]},2)}
	ACTIVATE MSDIALOG oDlgPvt CENTERED
	
	RestArea(aArea)
Return