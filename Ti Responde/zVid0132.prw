/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/03/11/como-percorrer-varios-pastas-e-subpastas-via-advpl-com-batch-no-windows-ti-responde-0132/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0132
Exemplo de como buscar vários arquivos de uma pasta usando um script do Windows
@type  Function
@author Atilio
@since 23/02/2024
@obs Solução criada como alternativa a https://terminaldeinformacao.com/2018/09/25/funcao-retorna-varios-arquivos-de-pastas-subpastas-em-advpl/

Foi usado como referência o seguinte link: https://superuser.com/questions/1010287/how-to-recursively-list-files-and-only-files-in-windows-command-prompt
/*/

User Function zVid0132()
    Local aArea     := FWGetArea()
    Local cPasta    := FWInputBox("Informe o caminho (ex.: C:\pasta\):")
    Local cDirTemp  := GetTempPath()
    Local cArqBatch := "gera_lista.bat"
    Local cListaTmp := "lista_arq.txt"
    Local cComando  := ""
    Local oFile
    Local nLinhaAtu := 0
    Local cNomeArq  := ""
    Local cLog      := ""

    //Se foi inserido o texto e a pasta existir no S.O.
    If ! Empty(cPasta) .And. ExistDir(cPasta)

        //Se o arquivo temporário já existir, apaga ele
        If File(cDirTemp + cListaTmp)
            FErase(cDirTemp + cListaTmp)
        EndIf

        //Se o batch já existir, apaga ele
        If File(cDirTemp + cArqBatch)
            FErase(cDirTemp + cArqBatch)
        EndIf

        //Aciona o comando para listar todos os arquivos, e gravar num arquivo temporário a lista
        //  Exemplo do comando completo:
        //  dir "C:\spool\" /A-D /S /B > "C:\Users\danat\AppData\Local\Temp\lista_arq.txt"
        cComando := 'dir "' + cPasta + '" /A-D /S /B > "' + cDirTemp + cListaTmp + '"'
        MemoWrite(cDirTemp + cArqBatch, cComando)

        //Agora executa o bat para gerar o arquivo
        ShellExecute("OPEN", cDirTemp + cArqBatch, "", cDirTemp, 0 )

        //Se conseguiu gerar o arquivo temporário
        If File(cDirTemp + cListaTmp)
            //Tenta abrir o arquivo e pegar o conteudo
            oFile := FwFileReader():New(cDirTemp + cListaTmp)
            If oFile:Open()

                //Enquanto tiver linhas
                While (oFile:HasLine())
                    nLinhaAtu++

                    //Pega a linha atual e exibe
                    cNomeArq := oFile:GetLine()
                    cLog += "Arquivo '" + StrZero(nLinhaAtu, 10) + "': " + cNomeArq + CRLF

                    //Aqui se você quiser aproveitar, consegue utilizar a cNomeArq, ela vai ter o nome de cada arquivo, ai você
                    //   pode fazer comandos, como por exemplo, File(cNomeArq), MemoRead(cNomeArq), etc
                EndDo

                //Exibe o log gerado
                ShowLog(cLog)
            EndIf
            oFile:Close()
        EndIf

    Else
        FWAlertError("Pasta inválida!", "Falha")
    EndIf

    FWRestArea(aArea)
Return
