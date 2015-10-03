//Bibliotecas 
#INCLUDE "Protheus.ch"
#INCLUDE "RwMake.ch"
#INCLUDE "Topconn.ch"
#INCLUDE "TbiConn.ch"

//Constantes
#Define CLR_VERMELHO  RGB(255,048,048)	//Cor Vermelha
#Define CLR_AZUL	  RGB(058,074,119)	//Cor Azul

//-----------------------------------------------------------------//
	/*/{Protheus.doc} zPegaWeb
	Função que gera uma imagem através de uma WebCam.
	@author Daniel Atilio
	@since  17/06/2014
	@version 1.0
		@param  cNome, Caracter, Nome do arquivo que será gerado
		@return aRet,  Array contendo duas colunas (se a rotina foi confirmada e o nome full do arquivo gerado) 
	@example
	u_zPegaWeb("IMAGEM")
	@obs É necessário a utilização de duas dll (colocar dentro da /smartclient/), que são escapi.dll e imageload2.dll.
	Para tirar fotos na tela da webcam é preciso pressionar a tecla F2.
	@see http://terminaldeinformacao.com/advpl/
	/*/
//-----------------------------------------------------------------//

User Function zPegaWeb(cNome)
	Local   cIdFile   := ""						//ID do arquivo (nome do parametro + "_NAO_SALVO"
	Local   cFileBmp  := ""						//Nome do arquivo com extensão jpg
	Local   cPathLoc  := ""						//Diretório local que será gerado o arquivo
	Local   nComboSel := 1 						//Item selecionado do combo
	Local	cDispos   := ""						//Contém a lista de dispositivos
	Local	cTam      := ""						//Tamanho da tela apresentada
	Local	aItens    := {}						//Contém todos os dispositivos
	Local   oFontNeg  := TFont():New("Tahoma")	//Fonte Negrita
	Local   oFont	  := TFont():New("Tahoma")	//Fonte Normal
	Local   oDlgWeb								//Dialog
	Local   oGrpWeb, oGrpPre					//Grupos da Dialog
	Local   oSayEsc, oSayCam, oSayF2			//Labels da Dialog
	Local   oCmbCams							//Combo da Dialog
	Local   oGetCam, cGetCam := ""				//Gets da Dialog
	Local   oBtnConf, oBtnCanc, oBtnAbre		//Botões da Dialog
	Private nRet	  := 0 						//Retornos das execuções das dlls
	Private aRet      := {.F.,""}				//Retorno [1] = Rotina Confirmada? ; [2] = Nome do arquivo
	Private cPathFile := ""						//Arquivo + diretório (ex.: C:\totvs\imagem.jpg)
	Private nHandle       						//Guarda o ponteiro da abertura da dll
	Private oBmpWeb                				//Bitmap que mostrará a foto na oDlgWeb
	
	//Setando atributo
	oFontNeg:Bold := .T.
	
	//Criando um nome para o arquivo
	Default cNome  := "IMAGEM"
	cIdFile        := cNome+"_WEB_CAM"
	cFileBmp	   := Alltrim(cIdFile)+".bmp"
	cPathLoc	   := GetTempPath()  
	cPathFile      := Upper(cPathLoc+cFileBmp)
	cGetCam        := cPathFile
	
	//Iniciando controle para manipulação da dll
	Begin Sequence
	  	
	  	//Abrindo a DLL para
		nHandle := ExecInDLLOpen("imageload2.DLL")  
		If nHandle == -1
		    MsgStop("Não foi possível carregar a DLL (imageload2).","Atenção")
		    Return
		EndIf     
		
		//Obtém lista de webcams
		nRet:=ExeDLLRun2( nHandle, 1, @cDispos) 
		cDispos := alltrim(cDispos)+alltrim(cDispos)
		aItens := StrTokArr(cDispos, "|")
		
		//Define a dimensão da captura (Largura|Altura)
		cTam:= "0400|0400"
	  	nRet:=ExeDLLRun2( nHandle, 3, @cTam)
		
		//Título da Janela que será aberta com a imagem
		cTitle := "WebCam (F2=Tira Foto)"
		nRet:=ExeDLLRun2( nHandle, 4, @cTitle) 

		//Criando a janela
		DEFINE MSDIALOG oDlgWeb TITLE "WebCam" FROM 000, 000  TO 545, 420 COLORS 0, 16777215 PIXEL
			//Grupo WebCam
			@ 000, 001 GROUP oGrpWeb TO 052, 208 PROMPT "WebCam: " OF oDlgWeb COLOR 0, 16777215 PIXEL
				//Combo de escolha da webcam
			    @ 008, 008 SAY 			oSayEsc 	PROMPT 	"Escolha:" 						SIZE 025, 007 OF oDlgWeb COLORS CLR_AZUL     FONT oFont 			PIXEL
			    @ 007, 051 MSCOMBOBOX 	oCmbCams 	VAR 	nComboSel ITEMS aItens 			SIZE 145, 010 OF oDlgWeb COLORS 0, 16777215 						PIXEL
			    //Caminho da imagem
			    @ 020, 008 SAY 			oSayCam 	PROMPT 	"Caminho:" 						SIZE 025, 007 OF oDlgWeb COLORS CLR_AZUL     FONT oFont 			PIXEL
			    @ 019, 051 MSGET 		oGetCam 	VAR 	cGetCam 						SIZE 144, 010 OF oDlgWeb COLORS 0, 16777215 READONLY 				PIXEL
			    //Label com observação
			    @ 044, 003 SAY 			oSayF2 		PROMPT 	"Tecla para salvar imagem F2" 	SIZE 101, 007 OF oDlgWeb COLORS CLR_VERMELHO FONT oFontNeg 			PIXEL
			    //Botões
			    @ 038, 169 BUTTON 		oBtnConf 	PROMPT 	"Confirmar" 					SIZE 037, 012 OF oDlgWeb ACTION {|| aRet[1]:=.T.,oDlgWeb:End() } 	PIXEL
			    @ 038, 130 BUTTON 		oBtnCanc 	PROMPT 	"Cancelar" 						SIZE 037, 012 OF oDlgWeb ACTION {|| aRet[1]:=.F.,oDlgWeb:End() } 	PIXEL
			    @ 038, 091 BUTTON 		oBtnAbre 	PROMPT 	"Abrir" 						SIZE 037, 012 OF oDlgWeb ACTION {|| fCaptura(oCmbCams:nAt) } 		PIXEL

			//Grupo Preview
			@ 057, 001 GROUP oGrpPre TO 270, 210 PROMPT "Preview: " OF oDlgWeb COLOR 0, 16777215 PIXEL
    			@ 067, 006 BITMAP oBmpWeb SIZE 200, 200 OF oDlgWeb NOBORDER PIXEL
    
    	//Ativando a janela
		ACTIVATE MSDIALOG oDlgWeb CENTERED
	End 
	
	ExecInDLLClose(nHandle)
Return aRet

/*---------------------------------------------------------------------*
 | Func:  fCaptura                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  17/06/2014                                                   |
 | Desc:  Função para abrir a WebCam e gravar a foto                   |
 | Obs.:  /                                                            |
 *---------------------------------------------------------------------*/

Static Function fCaptura(nAt)
	Local cImgPadrao := ""
	 
	//Definindo o dispositvo que será usado
	nRet:=ExeDLLRun2( nHandle, 2, @cValToChar(nAt-1)) 
    
    //Exclui o arquivo
   	fErase(cPathFile)
   	
	//Abre tela de captura e define arquivo de imagem de saida
	cImgPadrao := cPathFile
	nRet := ExeDLLRun2( nHandle, 5, cImgPadrao )
	
	//Altera a imagem para a dialog atualizar a cPathFile
	oBmpWeb:Load(,"ok.png")
	oBmpWeb:Refresh()
	
	//Exibe imagem capturada
	oBmpWeb:Load(,cPathFile)
	oBmpWeb:Refresh()

	//Se o arquivo existir, atualiza o retorno
	If File(cPathFile)
		aRet[2] := cPathFile
	//Senão, deixa em branco
	Else
		aRet[2] := ""
	EndIf
Return