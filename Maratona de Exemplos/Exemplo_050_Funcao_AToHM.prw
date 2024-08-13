/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/09/27/conversao-de-array-para-hashmap-com-a-funcao-atohm-maratona-advpl-e-tl-050/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe050
Exemplo de função que converte um Array para um objeto HashMap
@type Function
@author Atilio
@since 01/12/2022
@see https://tdn.totvs.com/display/tec/AToHM
@obs 
    Função AToHM
    Parâmetros
        + aMatriz   , Array      , Indica o nome do array que será transformado em objeto
        + nColuna_1 , Numérico   , Indica o número da coluna que será a chave da pesquisa
        + nTrim_1   , Numérico   , Indica o tipo de trim que será aplicado em dados caractere (0 = mantém; 1 = tira espaços a esquerda; 2 = tira espaços a direita; 3 = tira espaços de ambos os lados)
        + nColuna_2 , Numérico   , Indica o número da coluna que será a chave da pesquisa
        + nTrim_2   , Numérico   , Indica o tipo de trim que será aplicado em dados caractere (0 = mantém; 1 = tira espaços a esquerda; 2 = tira espaços a direita; 3 = tira espaços de ambos os lados)
        + nColuna_3 , Numérico   , Indica o número da coluna que será a chave da pesquisa
        + nTrim_3   , Numérico   , Indica o tipo de trim que será aplicado em dados caractere (0 = mantém; 1 = tira espaços a esquerda; 2 = tira espaços a direita; 3 = tira espaços de ambos os lados)
        + nColuna_4 , Numérico   , Indica o número da coluna que será a chave da pesquisa
        + nTrim_4   , Numérico   , Indica o tipo de trim que será aplicado em dados caractere (0 = mantém; 1 = tira espaços a esquerda; 2 = tira espaços a direita; 3 = tira espaços de ambos os lados)
        + nColuna_5 , Numérico   , Indica o número da coluna que será a chave da pesquisa
        + nTrim_5   , Numérico   , Indica o tipo de trim que será aplicado em dados caractere (0 = mantém; 1 = tira espaços a esquerda; 2 = tira espaços a direita; 3 = tira espaços de ambos os lados)
        + nColuna_6 , Numérico   , Indica o número da coluna que será a chave da pesquisa
        + nTrim_6   , Numérico   , Indica o tipo de trim que será aplicado em dados caractere (0 = mantém; 1 = tira espaços a esquerda; 2 = tira espaços a direita; 3 = tira espaços de ambos os lados)
        + nColuna_7 , Numérico   , Indica o número da coluna que será a chave da pesquisa
        + nTrim_7   , Numérico   , Indica o tipo de trim que será aplicado em dados caractere (0 = mantém; 1 = tira espaços a esquerda; 2 = tira espaços a direita; 3 = tira espaços de ambos os lados)
        + nColuna_8 , Numérico   , Indica o número da coluna que será a chave da pesquisa
        + nTrim_8   , Numérico   , Indica o tipo de trim que será aplicado em dados caractere (0 = mantém; 1 = tira espaços a esquerda; 2 = tira espaços a direita; 3 = tira espaços de ambos os lados)
    Retorno
        + oHash     , Objeto     , Objeto instanciado da classe THashMap

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe050()
    Local aArea      := FWGetArea()
    Local aDadosMult := {}
    Local oHashTst
    Local cBusca     := ""
    Local lEncontrou := .F.
    Local aLinha     := {}

    //Adicionando elementos no Array (código, nome e idade)
    aAdd(aDadosMult, {"0001", "Daniel",   23})
    aAdd(aDadosMult, {"0002", "Atilio",   33})
    aAdd(aDadosMult, {"0003", "João",     43})
    aAdd(aDadosMult, {"0004", "Maria",    53})
    aAdd(aDadosMult, {"0005", "José",     63})

    //Converte o Array para um THashMap, colocando como chave a coluna 1 e sem tirar espaços do conteúdo caractere
    oHashTst := AToHM(aDadosMult, 1, 0)

    //Efetua a busca do código via HMGet, se encontrou vai colocar na variável aLinha
    cBusca := "0003"
    lEncontrou := HMGet(oHashTst, cBusca, aLinha)

    //Se encontrou, iremos verificar o conteúdo do aLinha
    If lEncontrou
        ShowLog( ;
            VarInfo("aLinha", aLinha, , .F.) ;
        )
    EndIf

    //Limpa o Hash da memória e libera o objeto
    HMClean(oHashTst)
    FreeObj(oHashTst)

    FWRestArea(aArea)
Return
