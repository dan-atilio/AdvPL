/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2023/08/09/operador-de-contido-em-maratona-advpl-e-tl-001/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe001
Exemplo de como utilizar o operador $ (cifrão), para ver se um conteúdo texto está contido em outro
@type Function
@author Atilio
@since 26/11/2022
@see https://tdn.engpro.totvs.com.br/display/tec/Operadores+Comuns
@obs
    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe001()
    Local aArea  := FWGetArea()
    Local cLetra := "a"
    Local cNome  := "ATILIO"

    //Se a letra estiver "contida" na variável do nome
    If cLetra $ cNome
        FWAlertInfo("A letra esta contida no Nome", "Teste 1")
    EndIf

    //Se a letra (tudo maiúscula) estiver "contida" na variável do nome (tudo maiúscula)
    If Upper(cLetra) $ (cNome)
        FWAlertInfo("A letra esta contida no Nome (variáveis tudo maiúsculas)", "Teste 2")
    EndIf

    FWRestArea(aArea)
Return
