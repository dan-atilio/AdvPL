/*
    
    Esse é um exemplo disponibilizado no eBook AdvPL e TLPP 
    Esse eBook, está disponível no seguinte link: https://www.amazon.com.br/dp/B0F32JV54N 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zFonte58
Exemplo de função que realiza leituras de um arquivo
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWFileReader
/*/

User Function zFonte58()
    Local aArea := FWGetArea()
    Local cArquivo := "C:\spool\log_produtos.txt"
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
