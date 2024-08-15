/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/03/13/extrair-imagens-do-cadastro-de-produtos-ti-responde-047/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0047
Função que exporta as imagens para uma pasta da máquina do usuário
@type  Function
@author Atilio
@since 28/06/2022
/*/

User Function zVid0047()
    Local aArea := FWGetArea()

    //Somente se a pergunta for confirmada
    If MsgYesNo("Deseja exportar as imagens dos produtos para uma pasta?", "Atenção")
        Processa({|| fExporta() }, "Exportando imagens do repositório...")
    EndIf

    FWRestArea(aArea)
Return

Static Function fExporta()
    Local nAtual := 0
    Local nTotal := 0
	Local oReposit
	Local oDlgExp
    Local cDirExport := "C:\spool\imagens\"
    Local cFoto      := ""
    Local cFotoFull  := ""
	
    //Se a pasta de importados não existir, cria
    If ! ExistDir(cDirExport)
        MakeDir(cDirExport)
    EndIf

    //Define o repositório como o SIGAADV
	SetRepName("SIGAADV")

    DbSelectArea("SB1")
    SB1->(DbSetOrder(1)) // B1_FILIAL + B1_COD
    Count To nTotal
    SB1->(DbGoTop())

    //Monta uma dialog de 1 pixel, apenas para poder instanciar um repositório
	DEFINE MSDIALOG oDlgExp TITLE "Exportação - Repositório de Imagens" FROM 000, 000  TO 001, 001 PIXEL
    
        //Instancia um repositorio
		@ 000,000 REPOSITORY oReposit SIZE 0,0 OF oDlgExp
        
        //Enquanto houver dados
        While ! SB1->(EoF())
            //Incrementa a régua de processamento
            nAtual++
			IncProc("Analisando produto " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + " (" + Alltrim(SB1->B1_DESC) + ")...")
            
            //Se tiver foto do produto cadastrada
            cFoto := SB1->B1_BITMAP
            If ! Empty(cFoto)

                //Extrai a foto como jpg
                cFotoFull := cDirExport + Alltrim(SB1->B1_COD) + ".jpg"
                If ! Empty(cFoto)
                    oReposit:Extract(cFoto, cFotoFull, .F.)
                EndIf

                //Caso não tenha extraido, tenta extrair o .bmp
                If ! File(cFotoFull)
                    cFotoFull := cDirExport + Alltrim(SB1->B1_COD) + ".bmp"
                    If ! Empty(cFoto)
                        oReposit:Extract(cFoto, cFotoFull, .F.)
                    EndIf
                EndIf

            EndIf

            SB1->(DbSkip())
		EndDo
	
    //Ao abrir a dialog, já fecha ela
	ACTIVATE MSDIALOG oDlgExp CENTERED ON INIT (oDlgExp:End()) 
    
    //Fecha o repositório de imagens
	FechaReposit()
Return
