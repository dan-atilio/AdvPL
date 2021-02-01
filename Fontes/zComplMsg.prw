#include "Protheus.ch"
#include "TopConn.ch" 

// Má¡ximo de caracteres por linha de dados adicionais - deixar igual o do fonte danfeii.prw
#define MAXMENLIN 088
#define CTRF Chr(13) + Chr(10) 

//1 - Criar uma Fórmula (SM4), com u_zComplMsg()
//2 - Colocar o código dessa fórmula no campo C5_MENPAD

User Function zComplMsg()
	Local aArea	   := GetArea()
	Local aAreaSD2 := SD2->(GetArea())
	Local aAreaSF2 := SF2->(GetArea())
	Local aAreaSC5 := SC5->(GetArea())
	Local aAreaSC6 := SC6->(GetArea())
	Local aAreaSA1 := SA1->(GetArea())
	Local aAreaSB1 := SB1->(GetArea())
	Local aAreaSA3 := SA3->(GetArea())
	Local aAreaSF4 := SF4->(GetArea())
	Local cMens    := ""          
	Local cAux     := ""
	
	cAux := "Beluguinha, Belugão... Acesse Terminal de Informação (https://terminaldeinformacao.com)"
	cMens += fLinhaDanfe(cAux)
	
	RestArea(aAreaSD2)
	RestArea(aAreaSF2)
	RestArea(aAreaSC5)
	RestArea(aAreaSC6) 
	RestArea(aAreaSA1)
	RestArea(aAreaSB1)	
	RestArea(aAreaSA3)	   
	RestArea(aAreaSF4)	
	RestArea(aArea)
Return cMens

Static Function fLinhaDanfe(cLinhaTexto)
	Local cLinhaTrans:=""

	// Se houver texto.
	If ! Empty(cLinhaTexto)
		// Enquanto o tamnho for maior que o máximo da linha, vai quebrando. 
		While Len(cLinhaTexto) > MAXMENLIN
			cLinhaTrans += Substr(cLinhaTexto, 1, Rat(" ", Substr(cLinhaTexto, 1, MAXMENLIN)) - 1) + CTRF
            cLinhaTexto := Substr(cLinhaTexto, Rat(" ", Substr(cLinhaTexto, 1, MAXMENLIN)), Len(cLinhaTexto))
		EndDo
		
		// Se restou texto, incrementa.
		If (cLinhaTexto) != ""
			cLinhaTrans += cLinhaTexto
		EndIf	
	EndIf
	
Return cLinhaTrans