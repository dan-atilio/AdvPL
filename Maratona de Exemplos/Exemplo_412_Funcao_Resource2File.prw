/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/05/13/pegando-o-codigo-do-usuario-logado-com-a-retcodusr-maratona-advpl-e-tl-413/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe412
Salva uma imagem do repositório em um arquivo local
@type Function
@author Atilio
@since 28/03/2023
@see https://tdn.totvs.com/display/tec/Resource2File
@obs 

    Função Resource2File
    Parâmetros
        + cResource , Caractere     , Nome do Recurso buscado
        + cFile     , Caractere     , Nome do Arquivo na máquina local
    Retorno
        + lSucess   , Lógico        , .T. se conseguiu salvar o arquivo ou .F. se não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe412()
    Local aArea     := FWGetArea()
    
    //Pega o arquivo dentro do RPO e salva em uma pasta local
    Resource2File("PESQUISA.PNG", "C:\spool\teste2.png")

    FWRestArea(aArea)
Return
