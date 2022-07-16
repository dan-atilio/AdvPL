/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/07/11/importacao-de-pre-nota-de-entrada-via-csv-ou-txt-ti-responde-013/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0013
Função que realiza a importação do CSV como Pré Nota
@type  Function
@author Atilio
@since 23/02/2022
/*/

User Function zVid0013()
    Local aArea   := FWGetArea()
    Local cDirIni := GetTempPath()
    Local cTipArq := "Arquivos com separações (*.csv)"
    Local cTitulo := "Seleção de Arquivos para Processamento"
    Local lSalvar := .F.
    Local cArqSel := ""
 
    //Se não estiver sendo executado via job
    If ! IsBlind()
 
        //Chama a função para buscar arquivos
        cArqSel := tFileDialog(;
            cTipArq,;  // Filtragem de tipos de arquivos que serão selecionados
            cTitulo,;  // Título da Janela para seleção dos arquivos
            ,;         // Compatibilidade
            cDirIni,;  // Diretório inicial da busca de arquivos
            lSalvar,;  // Se for .T., será uma Save Dialog, senão será Open Dialog
            ;          // Se não passar parâmetro, irá pegar apenas 1 arquivo; Se for informado GETF_MULTISELECT será possível pegar mais de 1 arquivo; Se for informado GETF_RETDIRECTORY será possível selecionar o diretório
        )

        //Se tiver o arquivo selecionado e ele existir
        If ! Empty(cArqSel) .And. File(cArqSel)
            Processa({|| fImporta(cArqSel) }, "Importando...")
        EndIf
    EndIf

    FWRestArea(aArea)
Return

Static Function fImporta(cArqSel)
    Local cDirLog    := GetTempPath()
    Local cArqLog    := "zFat07Im_" + dToS(Date()) + "_" + StrTran(Time(), ':', '-') + ".log"
	Local nTotLinhas := 0
	Local cLinAtu    := ""
	Local nLinhaAtu  := 0
	Local aLinha     := {}
    Local oArquivo
    Local aLinhas
    Local aLinhaSD1 := {}
    Local cItem     := StrTran(Space(TamSX3('D1_ITEM')[01]), ' ', '0')
    //Primeira coluna do Excel, será o tipo da linha
    Private nPosTip  := 1 //SF1 ou SD1
    //Posições do Cabeçalho (SF1)
    Private nCabTipo := 2 //F1_TIPO
    Private nCabForm := 3 //F1_FORMUL
    Private nCabDocu := 4 //F1_DOC
    Private nCabSeri := 5 //F1_SERIE
    Private nCabEmis := 6 //F1_EMISSAO
    Private nCabForn := 7 //F1_FORNECE
    Private nCabLoja := 8 //F1_LOJA
    Private nCabEspe := 9 //F1_ESPECIE
    Private nCabCond := 10 //F1_COND
    //Posições dos Itens (SD1)
    Private nIteProd := 2 //D1_COD
    Private nIteQtde := 3 //D1_QUANT
    Private nIteVUni := 4 //D1_VUNIT
    Private nIteTpES := 5 //D1_TES
    //Variáveis do ExecAuto
    Private aCabecSF1       := {}
    Private aItensSD1       := {}
    Private lMSHelpAuto     := .T.
    Private lAutoErrNoFile  := .T.
    Private lMsErroAuto     := .F.
    Private cLog            := ""
    Private cChaveSF1       := ""
	
    //Abre as tabelas que serão usadas
	DbSelectArea('SF1')
	SF1->(DbSetOrder(1)) //F1_FILIAL + F1_DOC + F1_SERIE + F1_FORNECE + F1_LOJA + F1_TIPO
	SF1->(DbGoTop())
			
    //Definindo o arquivo a ser lido
    oArquivo := FWFileReader():New(cArqSel)
    
    //Se o arquivo pode ser aberto
    If (oArquivo:Open())

        //Se não for fim do arquivo
        If ! (oArquivo:EoF())

            //Definindo o tamanho da régua
            aLinhas := oArquivo:GetAllLines()
            nTotLinhas := Len(aLinhas)
            ProcRegua(nTotLinhas)
            
            //Método GoTop não funciona (dependendo da versão da LIB), deve fechar e abrir novamente o arquivo
            oArquivo:Close()
            oArquivo := FWFileReader():New(cArqSel)
            oArquivo:Open()

            //Iniciando controle de transação
            Begin Transaction

                //Enquanto tiver linhas
                While (oArquivo:HasLine())

                    //Incrementa na tela a mensagem
                    nLinhaAtu++
                    IncProc("Analisando linha " + cValToChar(nLinhaAtu) + " de " + cValToChar(nTotLinhas) + "...")
                    
                    //Pegando a linha atual e transformando em array
                    cLinAtu := oArquivo:GetLine()
                    aLinha  := StrTokArr(cLinAtu, ";")
                    
                    //Se houver posições no array
                    If Len(aLinha) > 0
                        //Se for cabeçalho
                        If Upper(aLinha[nPosTip]) == "SF1"
                            //Se tiver cabeçalho e itens, chama a rotina para acionar o ExecAuto
                            fPreNota()

                            //Zera as variáveis
                            aCabecSF1 := {}
                            aItensSD1 := {}
                            cItem     := StrTran(Space(TamSX3('D1_ITEM')[01]), ' ', '0')
                            cChaveSF1 := ""

                            //Se tiver o mesmo numero de colunas, adiciona no array da sf1, e monta a chave que será pesquisada no seek
                            If Len(aLinha) == nCabCond
                                //Transforma a data
                                If "/" $ aLinha[nCabEmis]
                                    aLinha[nCabEmis] := cToD(aLinha[nCabEmis])
                                Else
                                    aLinha[nCabEmis] := sToD(aLinha[nCabEmis])
                                EndIf

                                aAdd(aCabecSF1, {"F1_TIPO"    , aLinha[nCabTipo] , Nil})
                                aAdd(aCabecSF1, {"F1_FORMUL"  , aLinha[nCabForm] , Nil})
                                aAdd(aCabecSF1, {"F1_DOC"     , aLinha[nCabDocu] , Nil})
                                aAdd(aCabecSF1, {"F1_SERIE"   , aLinha[nCabSeri] , Nil})
                                aAdd(aCabecSF1, {"F1_EMISSAO" , aLinha[nCabEmis] , Nil})
                                aAdd(aCabecSF1, {"F1_FORNECE" , aLinha[nCabForn] , Nil})
                                aAdd(aCabecSF1, {"F1_LOJA"    , aLinha[nCabLoja] , Nil})
                                aAdd(aCabecSF1, {"F1_ESPECIE" , aLinha[nCabEspe] , Nil})
                                aAdd(aCabecSF1, {"F1_COND"    , aLinha[nCabCond] , Nil})

                                cChaveSF1 := FWxFilial("SF1") +;
                                    PadR(aLinha[nCabDocu], TamSX3("F1_DOC")[1], ' ') +;
                                    PadR(aLinha[nCabSeri], TamSX3("F1_SERIE")[1], ' ') +;
                                    PadR(aLinha[nCabForn], TamSX3("F1_FORNECE")[1], ' ') +;
                                    PadR(aLinha[nCabLoja], TamSX3("F1_LOJA")[1], ' ') +;
                                    PadR(aLinha[nCabTipo], TamSX3("F1_TIPO")[1], ' ')
                            EndIf

                        //Se for itens (e tiver todas as posições)
                        ElseIf Upper(aLinha[nPosTip]) == "SD1" .And. Len(aLinha) == nIteTpES
                            //Campos numéricos, retira ponto, transforma vírgula em ponto e converte para numérico
                            aLinha[nIteQtde] := Alltrim(aLinha[nIteQtde])
                            aLinha[nIteQtde] := StrTran(aLinha[nIteQtde], ".", "")
                            aLinha[nIteQtde] := StrTran(aLinha[nIteQtde], ",", ".")
                            aLinha[nIteQtde] := Val(aLinha[nIteQtde])
                            aLinha[nIteVUni] := Alltrim(aLinha[nIteVUni])
                            aLinha[nIteVUni] := StrTran(aLinha[nIteVUni], ".", "")
                            aLinha[nIteVUni] := StrTran(aLinha[nIteVUni], ",", ".")
                            aLinha[nIteVUni] := Val(aLinha[nIteVUni])

                            //Adiciona no array de Itens
                            cItem := Soma1(cItem)
                            aLinhaSD1 := {}
                            aAdd(aLinhaSD1, {"D1_ITEM"  , cItem     		                  , Nil} )
                            aAdd(aLinhaSD1, {"D1_COD"   , aLinha[nIteProd]                    , Nil} )
                            aAdd(aLinhaSD1, {"D1_QUANT" , aLinha[nIteQtde]                    , Nil} )
                            aAdd(aLinhaSD1, {"D1_VUNIT" , aLinha[nIteVUni]                    , Nil} )
                            aAdd(aLinhaSD1, {"D1_TOTAL" , aLinha[nIteQtde] * aLinha[nIteVUni] , Nil} )
                            aAdd(aLinhaSD1, {"D1_TES"   , aLinha[nIteTpES]                    , Nil} )
                            aAdd(aItensSD1, aClone(aLinhaSD1))
                        EndIf
                    EndIf
                    
                EndDo

                //Chama novamente a rotina de pré-nota pois pode ser que sobrou um cabec e itens para processar
                fPreNota()
            End Transaction
        
            //Se tiver log, mostra ele
            If ! Empty(cLog)
                MemoWrite(cDirLog + cArqLog, cLog)
                ShellExecute("OPEN", cArqLog, "", cDirLog, 1)
            EndIf

        Else
            MsgStop("Arquivo não tem conteúdo!", "Atenção")
        EndIf

        //Fecha o arquivo
        oArquivo:Close()
    Else
        MsgStop("Arquivo não pode ser aberto!", "Atenção")
    EndIf

Return

Static Function fPreNota()
    Local cPastaErro := ""
    Local cNomeErro  := ""
    Local cTextoErro := ""
    Local aLogErro   := {}
    Local nLinhaErro := 0

    //Se tiver cabeçalho e itens
    If Len(aCabecSF1) > 0 .And. Len(aItensSD1) > 0
        //Se conseguir posicionar na nota, grava no log que já existe
        If SF1->(MsSeek(cChaveSF1))
            cLog += "- NF já existe na base, chave de pesquisa: " + cChaveSF1 + CRLF

        //Aciona o ExecAuto
        Else
            lMsErroAuto := .F.
            MSExecAuto({|x, y, z| MATA140(x, y, z)}, aCabecSF1, aItensSD1, 3)
            
            //Se houve erro, gera o log
            If lMsErroAuto
                cPastaErro := "\x_logs\"
                cNomeErro  := "pre_nota_" + dToS(Date()) + "_" + StrTran(Time(), ":", "-") + ".txt"

                //Se a pasta de erro não existir, cria ela
                If ! ExistDir(cPastaErro)
                    MakeDir(cPastaErro)
                EndIf

                //Pegando log do ExecAuto, percorrendo e incrementando o texto
                aLogErro := GetAutoGRLog()
                For nLinhaErro := 1 To Len(aLogErro)
                    cTextoErro += aLogErro[nLinhaErro] + CRLF
                Next
                
                //Criando o arquivo txt e incrementa o log
                MemoWrite(cPastaErro + cNomeErro, cTextoErro)
                cLog += "- Falha ao incluir NF, chave de pesquisa: " + cChaveSF1 + ", arquivo de log em '" + cPastaErro + cNomeErro + "' " + CRLF
            Else
                cLog += "- NF incluida como pré-nota, chave de pesquisa: " + cCha