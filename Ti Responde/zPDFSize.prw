/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/08/22/comprimir-um-arquivo-pdf-via-advpl-ti-responde-018/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zPDFSize
Função que diminui o tamanho de um pdf para enviar por e-Mail
@type  Function
@author Atilio
@since 19/07/2021
@version version
@param cOrigFile, Caractere, Arquivo de origem junto com o caminho da pasta
@param cDestFile, Caractere, Arquivo de destino junto com o caminho da pasta
@example
    u_zPDFSize(;
        "C:\Spool\teste2.pdf",;
        "C:\Spool\teste2_menor.pdf";
    )
@obs É necessário ter instalado o GhostScript
    Link para Download: https://ghostscript.com/releases/gsdnld.html

    Não é indicado usar esse comando direto no servidor (via WaitRunSrv),
    pois pode causar travamentos no AppServer (ficar aguardando terminar o script)
/*/

User Function zPDFSize(cOrigFile, cDestFile)
    Local aArea    := FWGetArea()
    Local cComando := ""
    Local cDir     := GetTempPath()
    Local cNomBat  := "diminui_pdf.bat"

    //Somente se existir o arquivo no local de origem
    If File(cOrigFile)
        //Monta o comando que será executado no GhostScript
        cComando := '"C:\Program Files\gs\gs9.55.0\bin\gswin64.exe" -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile="' + cDestFile + '" "' + cOrigFile + '"'

        //Gravando em um .bat o comando
        MemoWrite(cDir + cNomBat, cComando)
        
        //Executando o comando através do .bat
        ShellExecute("OPEN", cDir + cNomBat, "", cDir, 0 )
    EndIf

    FWRestArea(aArea)
Return
