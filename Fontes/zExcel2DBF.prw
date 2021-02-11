/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2015/12/03/funcao-que-converte-excel-xls-para-dbf-em-advpl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zExcel2DBF
Função que converte arquivos do excel (*.xls*) em arquivos dBase (*.dbf), utilizando o LibreOffice para conversão
@author Atilio
@since 10/10/2014
@version 1.0
	@param cOrigem,  Caracter, Arquivo origem do Excel que será convertido
	@param cDestino, Caracter, Caminho dentro da Protheus_Data que ficará o .dbf
	@return lOk, Define se o arquivo dbf foi gerado
	@example
	lGerouDbf := u_zExcel2DBF("C:\arquivo.xlsx", "\especificos\")
	@obs
	Comandos Originais testados:
	soffice --convert-to dbf "E:\TOTVS11\Protheus_Data\especificos\arquivo.xlsx" --outdir "E:\TOTVS11\Protheus_Data\especificos" --invisible
	soffice --convert-to dbf "/home/atilio/arquivo.xlsx"                            --outdir "/home/atilio/Documents/"                --invisible
	
	Vale ressaltar, que para o devido funcionamento em ambientes Windows, você deve adicionar o caminho de execução do LibreOffice na Path do sistema.
	Ex.:
		Clique com o botão direito em Meu Computador > Propriedades > Configurações Avançadas do Sistema > Variáveis de Ambiente
		Em variáveis do sistema, ache a variável Path, clique em editar, no fim da variável, pressione ';', e coloque o caminho da instalação
		como C:\Program Files (x86)\LibreOffice 3.5\program\
	Para testar, pelo MS-DOS (Prompt de Comando), execute:
	> soffice --help
/*/

User Function zExcel2DBF(cOrigem, cDestino)
	Local cComando	:= ""
	Local cArq			:= ""
	Local cCamFull	:= GetSrvProfString ("ROOTPATH","") + cDestino
	Local lOk			:= .f.
	Local cRaiz		:= ""

	//Se for servidores, linux / unix / bsd, a barra será normal (/) e a raíz será '/'	
	If IsSrvUnix()
		cArq		:= SubStr(cOrigem,RAT("/",cOrigem)+1,Len(cOrigem))
		cCamFull	:= StrTran(cCamFull,"\","/")
		cRaiz		:= "/"
		
	//Se não (Windows), a barra será invertida (\) e a raíz será 'C:\'
	Else
		cArq		:= SubStr(cOrigem,RAT("\",cOrigem)+1,Len(cOrigem))
		cCamFull	:= StrTran(cCamFull,"/","\")
		cRaiz		:= "C:\"
	EndIf
	
	//Gerando o comando de conversão do LibreOffice, também é possível utilizar o scalc
	cComando += 'soffice --convert-to dbf "'+cCamFull+cArq+'" --outdir "'+SubStr(cCamFull,1,Len(cCamFull)-1)+'" --invisible'
	
	//Copiando o arquivo da estação para o servidor
	CpyT2S(cOrigem, cDestino)
	
	//Gravando e Executando o comando no servidor, aguardando ele ser executado, passando a raiz como referência
	MemoWrite(cDestino+"comando.txt", cComando)
	lOk := WaitRunSrv(cComando, .T., cRaiz)
Return lOk

/*/{Protheus.doc} zTstConv
Testa a conversão de arquivos xls e monta uma tabela temporária para manipulação
@author Atilio
@since 10/10/2014
@version 1.0
	@example
	u_zTstConv()
/*/

User Function zTstConv()
	Local aArea		:= GetArea()
	Local cTabTmp		:= 'TMP'
	Local cArqXLS		:= 'C:\TOTVS\arquivo.xlsx'
	Local cArqDBF		:= ''
	Local cDirSrv		:= '\especificos\'
	Local nLinha		:= 1
	Local lGerou		:= .F.
	
	//Se não existir o diretório, cria
	If !ExistDir(cDirSrv)
		MakeDir(cDirSrv)
	EndIf
	
	//Pegando o nome arquivo dbf, tirando o caminho absoluto e a extensão
	cArqDBF := SubStr(cArqXLS, RAt('\', cArqXLS)+1, Len(cArqXLS))
	cArqDBF := SubStr(cArqDBF, 1, At('.',cArqDBF))
	cArqDBF += "dbf"
	
	//Convertendo de xls para dbf
	lGerou := u_zExcel2DBF(cArqXLS, cDirSrv)

	//Se o dbf estiver gerado
	If lGerou
		//Usando o dbf como tabela temporária
		dbUseArea(.T., "DBFCDXADS", cDirSrv+cArqDBF, cTabTmp, .T., .F.)
		(cTabTmp)->(DbGoTop())
		
		//Enquanto tiver registros na tabela temporária
		While !((cTabTmp)->(EoF()))
			nLinha++
			(cTabTmp)->(DbSkip())
		EndDo
		(cTabTmp)->(DbCloseArea())
	EndIf
	
	RestArea(aArea)
Return