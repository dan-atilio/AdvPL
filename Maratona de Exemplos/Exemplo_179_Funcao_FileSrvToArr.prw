/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/17/validando-se-um-arquivo-existe-com-a-funcao-file-maratona-advpl-e-tl-178/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe179
Faz a leitura de um arquivo da Protheus Data para um Array
@type Function
@author Atilio
@since 20/12/2022
@obs 
    Função FileSrvToArr
    Parâmetros
        + Nome do arquivo completo com a pasta (pode ser local ou dentro da Protheus Data)
        + Indica onde será feito a pesquisa do arquivo (0=acesso conforme path; 1=diretório de instalação do AppServer; 2=Diretório de instalação do SmartClient)
        + Se for .T. o nome será convertido tudo para minúsculo senão se for .F. mantém o nome original como veio
    Retorno
        + Array com o conteúdo do arquivo sendo cada posição 1 linha do arquivo

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe179()
    Local aArea     := FWGetArea()
    Local cArqCompl := "\x_logs\log_auto.txt"
    Local aConteudo := {}

    //Busca o conteúdo do arquivo no servidor
    aConteudo := FileSrvToArr(cArqCompl)
    FWAlertInfo("Foi encontrado " + cValToChar(Len(aConteudo)) + " linha(s) de conteúdo", "Teste com FileSrvToArr")

    FWRestArea(aArea)
Return
