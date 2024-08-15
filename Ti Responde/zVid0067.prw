/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/07/31/baixar-arquivo-de-webservice-com-base64-ti-responde-067/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0067
Exemplo que mostra como transformar arquivo em string base 64 e vice e versa
@type  Function
@author Atilio
@since 10/09/2022
/*/

User Function zVid0067()
    Local cTexto := ""

    //Primeiro exemplo, pegar um arquivo que existe em PDF e transformar em Base 64
    cTexto := fPdfTo64()

    //Segundo exemplo, pegar uma string base 64 e transformar em PDF
    f64toPdf(cTexto)

Return

Static Function fPdfTo64()
    Local cArquivo  := "C:\spool\zrelprod.pdf"
    Local cConteudo := ""
    Local cString64 := ""
    Local oFile

    //Se o arquivo existir
    If File(cArquivo)

        //Tenta abrir o arquivo e pegar o conteudo
		oFile := FwFileReader():New(cArquivo)
		If oFile:Open()

            //Se deu certo abrir o arquivo, pega o conteudo e transforma em base 64
			cConteudo  := oFile:FullRead()
			cString64  := Encode64(cConteudo, , .F., .F.)

            FWAlertSuccess("Arquivo pdf transformado em string com base 64", "Arquivo em Base 64")
        EndIf
        oFile:Close()
    EndIf
Return cString64

Static Function f64toPdf(cString64)
    Local cDecode := ""
    Local cPasta  := GetTempPath()
    Local cArquivo := "prod_base64_" + dToS(Date()) + "_" + StrTran(Time(), ":", "-") + ".pdf"
    Default cString64 := ""

    //Se houver string
    If ! Empty(cString64)
        //Decodifica o conteudo e salva na temporária
        cDecode := Decode64(cString64)
        MemoWrite(cPasta + cArquivo, cDecode)

        //Agora abre o arquivo
        ShellExecute("open", cArquivo, "", cPasta, 1)
    EndIf
Return
