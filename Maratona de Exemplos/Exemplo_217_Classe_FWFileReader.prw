/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/05/lendo-arquivos-atraves-da-fwfilereader-maratona-advpl-e-tl-217/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe217
Exemplo de função que realiza leituras de um arquivo
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWFileReader
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe217()
    Local aArea := FWGetArea()
    Local cArquivo := "C:\spool\curso\exemplo_query.sql"
    Local cConteudo := ""
    Local oFile

    /*
        Exemplo 1 - Fazendo a leitura do arquivo inteiro
    */

    //Se o arquivo existir
    If File(cArquivo)

        //Tenta abrir o arquivo e pegar o conteudo
        oFile := FwFileReader():New(cArquivo)
        If oFile:Open()
 
            //Se deu certo abrir o arquivo, pega o conteudo e exibe
            cConteudo  := oFile:FullRead()
            ShowLog(cConteudo)
        EndIf
        oFile:Close()
    EndIf

    /*
        Exemplo 2 - Fazendo a leitura do arquivo linha a linha
    */

    //Se o arquivo existir
    If File(cArquivo)

        //Tenta abrir o arquivo e pegar o conteudo
        oFile := FwFileReader():New(cArquivo)
        If oFile:Open()
 
            //Pegando o total de linhas
            aLinhas := oFile:GetAllLines()
            nTotLinhas := Len(aLinhas)
            nLinhaAtu := 0
             
            //Método GoTop não funciona (dependendo da versão da LIB), deve fechar e abrir novamente o arquivo
            oFile:Close()
            oFile := FWFileReader():New(cArquivo)
            oFile:Open()

            //Enquanto tiver linhas
            While (oFile:HasLine())
                nLinhaAtu++

                //Pega a linha atual e exibe
                cLinAtu := oFile:GetLine()
                ShowLog("Linha '" + cValToChar(nLinhaAtu) + "': " + cLinAtu)
            EndDo
        EndIf
        oFile:Close()

    EndIf

    FWRestArea(aArea)
Return
