/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2017/01/23/vd-advpl-024/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

/*/{Protheus.doc} zExecView
Função de teste que demonstra o funcionamento da FWExecView
@type function
@author Atilio
@since 24/10/2016
@version 1.0
	@example
	u_zExecView()
@obs Se a rotina tiver grid, provavelmente será necessário declarar a variável "n" como private
/*/

User Function zExecView()
	Local aArea := GetArea()
	Local cFunBkp     := FunName()
	
	DbSelectArea('ZZ1')
	ZZ1->(DbSetOrder(1)) //Filial + Código
	
	//Se conseguir posicionar
	If ZZ1->(DbSeek(FWxFilial('ZZ1') + "000002"))
		SetFunName("zModel1")
		FWExecView('Visualizacao Teste', 'zModel1', MODEL_OPERATION_VIEW)
		SetFunName(cFunBkp)
	EndIf
	
	RestArea(aArea)
Return