/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/02/06/criando-arquivos-atraves-da-fwfilewriter-maratona-advpl-e-tl-218/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe218
Exemplo de função que realiza gravações em um arquivo
@type Function
@author Atilio
@since 20/02/2023
@see https://tdn.totvs.com/display/public/framework/FWFileWriter
@obs 

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe218()
    Local aArea    := FWGetArea()
    Local cArquivo := "C:\spool\curso\log_produtos.txt"
    Local oFWriter := Nil
    Local cLinha   := ""

    //Se o arquivo existir, irá apagar
    If File(cArquivo)
        FErase(cArquivo)
    EndIf

    //Cria o arquivo de logs
    oFWriter := FWFileWriter():New(cArquivo, .T.)

    //Se não foi possível criar o arquivo, encerra o Protheus
    If ! oFWriter:Create()
        Final("Houve um erro ao criar o arquivo - " + oFWriter:Error():Message)
    Else

        //Inicia o texto com um log genérico
        oFWriter:Write("Código do Usuário: " + RetCodUsr() + CRLF)
        oFWriter:Write("Nome do Usuário:   " + UsrRetName(RetCodUsr()) + CRLF)
        oFWriter:Write("Função (FunName):  " + FunName() + CRLF)
        oFWriter:Write("Ambiente:          " + GetEnvServer() + CRLF)
        oFWriter:Write(CRLF)
        oFWriter:Write("Log iniciado, data [" + dToC(Date()) + "] e hora [" + Time() + "]" + CRLF)
        oFWriter:Write("--" + CRLF)
        oFWriter:Write(CRLF)

        //Abre a tabela de produtos e posiciona no topo
        DbSelectArea("SB1")
        SB1->(DbSetOrder(1))
        SB1->(DbGoTop())

        //Enquanto houver produtos
        While ! SB1->(EoF())
            //Monta o texto da linha
            cLinha := "[" + Time() + "] "
            cLinha += " Prod: " + SB1->B1_COD  + ";"
            cLinha += " Tipo: " + SB1->B1_TIPO + ";"
            cLinha += " Desc: " + SB1->B1_DESC + ";"

            //Insere no arquivo
            oFWriter:Write(cLinha + CRLF)

            SB1->(DbSkip())
        EndDo

        //Mostra um texto no fim do arquivo
        oFWriter:Write(CRLF)
        oFWriter:Write("--" + CRLF)
        oFWriter:Write("Log encerrado, data [" + dToC(Date()) + "] e hora [" + Time() + "]")

        //Encerra o arquivo
        oFWriter:Close()

        //Se não for via job/webservice, abre o arquivo
        If ! IsBlind()
            ShellExecute("OPEN", cArquivo, "", "C:\spool\curso\", 1)
        EndIf
    EndIf

    FWRestArea(aArea)
Return
