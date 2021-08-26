/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, nos seguintes links:
		https://terminaldeinformacao.com/2021/08/30/como-enviar-mensagens-para-whatsapp-usando-advpl-tl/
		https://terminaldeinformacao.com/2021/09/06/como-enviar-emojis-para-whatsapp-usando-advpl-tl/
		https://terminaldeinformacao.com/2021/09/13/como-quebrar-linhas-em-mensagens-do-whatsapp-usando-advpl-tl/
		https://terminaldeinformacao.com/2021/09/20/enviando-arquivos-pelo-whatsapp-usando-advpl-tl/
		https://terminaldeinformacao.com/2021/09/27/como-fazer-um-menu-de-opcoes-com-analise-da-resposta-no-whatsapp-usando-advpl-tl/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zZapSend
Função que dispara uma mensagem para um smartphone com o aplicativo do WhatsApp
@type  Function
@author Atilio
@since 05/08/2021
@version version
@param cTelDestin, Caractere, Telefone de destino com o país 55 e o ddd - por exemplo 5514999998888
@param cMensagem,  Caractere, Mensagem que será enviada para esse WhatsApp
@param cAnexo,     Caractere, Caminho do arquivo que tem de estar dentro da Protheus Data
@return aRet, Array, Posição 1 define se deu certo o envio com .T. ou .F. e a Posição 2 é o JSON obtido como resposta do envio com o protocolo
@obs É necessário baixar a classe NETiZAP desenvolvida pelo grande Júlio Wittwer
    disponível em https://github.com/siga0984/NETiZAP/blob/master/NETiZAP.prw
/*/

User Function zZapSend(cTelDestin, cMensagem, cAnexo)
    Local aArea  := GetArea()
    Local cLinha := SuperGetMV("MV_X_ZAPLI", .F., "5521986855299")
    Local nPorta := SuperGetMV("MV_X_ZAPPO", .F., 13155)
    Local cChave := SuperGetMV("MV_X_ZAPCH", .F., "fUzanE5ncxlTAWBjMO30")
    Local aRet   := {.F., ""}
    Local oZap
    Local oFile
    Local cArqConteu
    Local cArqEncode
    Local cExtensao
    Local cArqNome
    Default cTelDestin := ""
    Default cMensagem  := ""
    Default cAnexo     := ""

    //Retira caracteres em branco dos lados
    cTelDestin := Alltrim(cTelDestin)
    cMensagem  := Alltrim(cMensagem)

    //Transforma o texto em UTF-8
    cMensagem := EncodeUTF8(cMensagem)

    //Retira caracteres especiais do telefone por exemplo +55 (14) 9 9999-8888
    cTelDestin := StrTran(cTelDestin, " ", "")
    cTelDestin := StrTran(cTelDestin, "+", "")
    cTelDestin := StrTran(cTelDestin, "(", "")
    cTelDestin := StrTran(cTelDestin, ")", "")
    cTelDestin := StrTran(cTelDestin, "-", "")

    //Se houver telefone, mensagem, o número for menor que 12 caracteres (551400000000) e não iniciar com 55 não irá enviar a mensagem
    If Empty(cTelDestin) .And. Empty(cMensagem) .And. Len(cTelDestin) < 12 .And. SubStr(cTelDestin, 1, 2) != "55"
        aRet[1] := .F.
        aRet[2] := '[{"error":"Parametro(s) enviado(s) para zZapSend, invalido(s)"}]'
    Else
        //Se na mesma mensagem, tiver o -Enter- normal e tags br, retira os -Enter-
        If CRLF $ cMensagem .And. "<br>" $ cMensagem
            cMensagem := StrTran(cMensagem, CRLF, '')
        EndIf

        //Agora, irá converter o restante para o formato que o WhatsApp entenda
        cMensagem := StrTran(cMensagem, CRLF   , '\n')
        cMensagem := StrTran(cMensagem, '<br>' , '\n')
        cMensagem := StrTran(cMensagem, '<b>'  , '*')
        cMensagem := StrTran(cMensagem, '</b>' , '*')
        cMensagem := StrTran(cMensagem, '<i>'  , '_')
        cMensagem := StrTran(cMensagem, '</i>' , '_')
        
        //Instancia a classe, e passa os parametros da NETiZAP
        oZap := NETiZAP():New(cLinha, cChave, nPorta)

        //Define o destino e a mensagem de envio
        oZap:SetDestiny(cTelDestin)
        oZap:SetText(cMensagem)

        //Se o parâmetro do arquivo estiver preenchido, e ele existir
        If ! Empty(cAnexo) .And. File(cAnexo)
            //Tenta abrir o arquivo
            oFile   := FwFileReader():New(cAnexo)
            If oFile:Open()
                //Busca o conteúdo do arquivo (foi usado FWFileReader ao invés de MemoRead, por causa de limitação de bytes na leitura)
                cArqConteu  := oFile:FullRead()
                cArqEncode  := Encode64(cArqConteu)

                //Busca a extensão do arquivo
                cExtensao := Upper(SubStr(cAnexo, RAt(".", cAnexo) + 1))

                //Busca o nome do arquivo sem extensão
                cArqNome := SubStr(cAnexo, RAt("\", cAnexo) + 1)

                //Só irá prosseguir, se for um pdf ou uma imagem
                If cExtensao $ "PDF,PNG,JPG,BMP,GIF"
                    //Se a extensão for PDF, tira o pdf do nome, para não ficar por exemplo, arquivo.pdf.pdf
                    If cExtensao == "PDF"
                        cArqNome := SubStr(cArqNome, 1, RAt(".", cArqNome) - 1)
                    EndIf
                    oZap:SetFile(cArqNome, cExtensao, cArqEncode)

                    //Atualiza o retorno conforme se a mensagem foi enviada ou houve falha
                    If oZap:FileSend()
                        aRet[1] := .T.
                        aRet[2] := oZap:GetResponse()
                    Else
                        aRet[1] := .F.
                        aRet[2] := oZap:GetLastError()
                    EndIf

                Else
                    aRet[1] := .F.
                    aRet[2] := '[{"error":"Extensao invalida, aguardando pdf ou imagens png, jpg, bmp e gif"}]'
                EndIf

                oFile:Close()
            EndIf

        //Senão existir o arquivo, irá ser enviado uma mensagem simples
        Else
            //Atualiza o retorno conforme se a mensagem foi enviada ou houve falha
            If oZap:MessageSend()
                aRet[1] := .T.
                aRet[2] := oZap:GetResponse()
            Else
                aRet[1] := .F.
                aRet[2] := oZap:GetLastError()
            EndIf
        EndIf
    EndIf

    RestArea(aArea)
Return aRet
