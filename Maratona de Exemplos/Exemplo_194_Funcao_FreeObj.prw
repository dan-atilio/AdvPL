/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/01/25/liberando-um-objeto-da-memoria-com-a-freeobj-maratona-advpl-e-tl-194/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe194
Limpa e libera um objeto da memória do Protheus
@type Function
@author Atilio
@since 11/02/2023
@see https://tdn.totvs.com/display/tec/FreeObj
@obs 
    Função FreeObj
    Parâmetros
        + oObj        , Objeto           , Nome da variável objeto instanciada
    Retorno
        Função não tem retorno

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe194()
    Local aArea     := FWGetArea()
    Local oObjeto

    //Instancia uma classe
    oObjeto := TFont():New("Tahoma", , -12)

    //Limpa e libera o objeto
    FreeObj(oObjeto)

    //Exibe uma mensagem com o tamannho do array
    FWAlertInfo("O valor da variável é " + cValToChar(ValType(oObjeto)), "Teste de FreeObj")

    FWRestArea(aArea)
Return
