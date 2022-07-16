/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/06/27/copiar-varios-arquivos-de-uma-pasta-a-outra-ti-responde-011/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0011
Função de exemplo copiando vários arquivos de uma pasta local para o servidor
@type  Function
@author Atilio
@since 28/01/2022
/*/

User Function zVid0011()
    Local aArea     := FWGetArea()
    Local cPastaLoc := "C:\spool\"
    Local cPastaDat := "\x_temp\"
    Local aArquivos := {}
    Local nAtual    := 0

    //Se a pasta não existir na Protheus Data, cria
    If ! ExistDir(cPastaDat)
        MakeDir(cPastaDat)
    EndIf

    //Busca todos os pdfs da pasta local
    aDir(cPastaLoc + "*.pdf", aArquivos)

    //Percorre todos os arquivos
    For nAtual := 1 To Len(aArquivos)
        __CopyFile(cPastaLoc + aArquivos[nAtual], cPastaDat + aArquivos[nAtual])
    Next

    FWRestArea(aArea)
Return
