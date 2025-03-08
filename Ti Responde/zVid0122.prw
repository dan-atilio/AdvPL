/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/02/04/criar-um-documento-de-entrada-em-outra-filial-ao-emitir-um-documento-de-saida-ti-responde-0122/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function M460FIM
Ponto de entrada após gerar o documento de saída
@type  Function
@author Atilio
@since 18/03/2024
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6784180
/*/

User Function M460FIM()
    Local aArea := FWGetArea()

    //Se o usuário confirmar a pergunta, aciona a geração do documento de entrada
    If FWAlertYesNo("Deseja gerar o Documento de Entrada?", "Entrada?")
        u_zVid0122()
    EndIf

    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function zVid0122
Gera Documento de Entrada através de um Documento de Saída
@type  Function
@author Atilio
@since 18/03/2024
@obs O ideal é utilizar a MATA311, mas se precisar de um recurso paliativo, pode se usar esse exemplo
/*/

User Function zVid0122()
    Local aArea     := FWGetArea()
	Local aAreaSF2  := SF2->(FWGetArea())
	Local aAreaSD2  := SD2->(FWGetArea())
    Local cFilDest  := "01" //"0201"
    Local cFilBkp   := cFilAnt
    Local aCabSF1   := {}
    Local aItensSD1 := {}
    Local aLinha    := {}
    Local cItem     := StrTran(Space(TamSX3('D1_ITEM')[01]), ' ', '0')
    Private lMsErroAuto := .F.

    //Monta o cabeçalho do documento de entrada
    aAdd(aCabSF1, {"F1_TIPO"    , "N"               , Nil})
    aAdd(aCabSF1, {"F1_FORMUL"  , "N"               , Nil})
    aAdd(aCabSF1, {"F1_DOC"     , SF2->F2_DOC       , Nil})
    aAdd(aCabSF1, {"F1_SERIE"   , SF2->F2_SERIE     , Nil})
    aAdd(aCabSF1, {"F1_EMISSAO" , SF2->F2_EMISSAO   , Nil})
    aAdd(aCabSF1, {"F1_FORNECE" , SF2->F2_CLIENTE   , Nil})
    aAdd(aCabSF1, {"F1_LOJA"    , SF2->F2_LOJA      , Nil})
    aAdd(aCabSF1, {"F1_ESPECIE" , "NFE"             , Nil})
    aAdd(aCabSF1, {"F1_COND"    , "C01"             , Nil})

    //Abre os itens da NF	
	DbSelectArea("SD2")
	SD2->(DbSetOrder(3)) // D2_FILIAL + D2_DOC + D2_SERIE + D2_CLIENTE + D2_LOJA + D2_COD + D2_ITEM
	SD2->(MsSeek( FWxFilial("SD2") + SF2->(F2_DOC+F2_SERIE) ))

    //Enquanto houver dados nos itens da NF e for o mesmo documento e série
	While ! SD2->(EOF()) .And. D2_FILIAL == FWxFilial("SD2") .And. (D2_DOC+D2_SERIE) == SF2->(F2_DOC+F2_SERIE)
		cItem := Soma1(cItem)

        //Adiciona uma linha no array do documento de entrada
        aLinha := {}
        aAdd(aLinha, {"D1_ITEM"    , cItem     		, Nil} )
        aAdd(aLinha, {"D1_COD"     , SD2->D2_COD    , Nil} )
        aAdd(aLinha, {"D1_QUANT"   , SD2->D2_QUANT  , Nil} )
        aAdd(aLinha, {"D1_VUNIT"   , SD2->D2_PRCVEN , Nil} )
        aAdd(aLinha, {"D1_TOTAL"   , SD2->D2_TOTAL  , Nil} )
        aAdd(aLinha, {"D1_TES"     , "001"          , Nil} )
        aAdd(aItensSD1, aClone(aLinha))

		SD2->(DbSkip())
	EndDo

    //Troca a filial para onde será inserido a entrada
    cFilAnt := cFilDest
    cNumEmp := cEmpAnt + cFilAnt
    OpenFile(cNumEmp)

    //Aciona a criação do documento de entrada
    MSExecAuto({|x, y, z| Mata103(x, y, z) }, aCabSF1, aItensSD1, 3)

    //Se houve erro, mostra ao usuário
    If lMsErroAuto
        MostraErro()
    EndIf

    //Volta a filial para a original
    cFilAnt := cFilBkp
    cNumEmp := cEmpAnt + cFilAnt
    OpenFile(cNumEmp)

	FWRestArea(aAreaSF2)
	FWRestArea(aAreaSD2)
	FWRestArea(aArea)
Return
