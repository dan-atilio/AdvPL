/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/04/funcoes-adir-e-directory-para-listar-arquivos-de-um-diretorio-maratona-advpl-e-tl-027/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe027
Exemplo de funções que buscam pastas e arquivos dentro de uma pasta através da aDir e Directory
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.totvs.com/display/tec/ADir e https://tdn.totvs.com/display/tec/Directory
@obs Função aDir
    Parâmetros
        + cEspecArq                 - Caractere  - Indica o diretório de pesquisa
        + aNomesArq   (Opcional)    - Array      - Indica o Array com nome dos arquivos
        + aTamanhos   (Opcional)    - Array      - Indica o Array com tamanho dos arquivos
        + aDatas      (Opcional)    - Array      - Indica o Array com data dos arquivos
        + aHoras      (Opcional)    - Array      - Indica o Array com horas dos arquivos
        + aAtributos  (Opcional)    - Array      - Inclui pastas e outros atributos (no link do TDN acima tem todos os tipos)
        + lChangeCase (Opcional)    - Lógico     - .F. mantém o nome do arquivo e .T. transforma para minúsculo
    Retorno
        + nRet                      - Numérico   - Quantidade de arquivos

    Função Directory
    Parâmetros
        + cDirEsp                   - Caractere  - Indica o diretório de pesquisa
        + cAtributos     (Opcional) - Caractere  - Inclui pastas, arquivos ocultos (no link do TDN acima tem todos os tipos)
        + uParam1        (Opcional) - Indefinido - Compatibilidade
        + lCaseSensitive (Opcional) - Lógico     - .F. mantém o nome do arquivo e .T. transforma para maiúsculo
        + nTypeOrder     (Opcional) - Numérico   - Tipo de Ordenação (1 nome do arquivo, 2 data do arquivo e 3 tamanho do arquivo)
    Retorno
        + aRet                      - Array      - Retorna um Array com os detalhes dos arquivos da pasta

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe027()
    Local aArea     := FWGetArea()
    Local aArqui1   := {}
    Local aArqui2   := {}

    //Busca arquivos via aDir
    aDir("C:\spool\*.*", aArqui1)

    //Busca arquivos via Directory
    aArqui2 := Directory("C:\spool\*.*")

    FWAlertInfo("Tamanho do aArqui1: " + cValToChar(Len(aArqui1)) + ", aArqui2: " + cValToChar(Len(aArqui2)), "Atenção")

    FWRestArea(aArea)
Return
