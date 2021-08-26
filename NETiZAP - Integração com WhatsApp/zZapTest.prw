/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2021/08/30/como-enviar-mensagens-para-whatsapp-usando-advpl-tl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zZapTest
Função de teste para envio de mensagens para o WhatsApp
@type  Function
@author Atilio
@since 05/08/2021
@version version
/*/

User Function zZapTest()
    Local aArea := GetArea()
    Local aZap  := {}

    //Faz o teste de envio
    aZap := u_zZapSend("5514999998888", "Olá Daniel, essa é uma mensagem de teste!")

    //Se houve falha, mostra a mensagem de erro
    If ! aZap[1]
        MsgStop(aZap[2], "Falha no envio")
    EndIf

    RestArea(aArea)
Return
