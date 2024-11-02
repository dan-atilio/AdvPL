/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/10/29/como-abrir-um-arquivo-ctree-via-advpl-ti-responde-0094/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} zVid0094
Exemplo de como abrir um arquivo dtc (ctree) via programação
@type user function
@author Atilio
@since 19/01/2024
/*/

User Function zVid0094()
    Local aArea     := FWGetArea()
    Local cRDD      := "CTREECDX"
    Local cAliasArq := GetNextAlias()
    Local cArquiAtu := "\x_temp\arquivo.dtc"
    Local cMensagem := ""

    //Somente se o arquivo existir
    If File(cArquiAtu)

        //Abre o arquivo CTREE
        DbUseArea(.T., cRDD, cArquiAtu, cAliasArq, .F., .F.)

        //Se tiver dados, exibe uma mensagem
        If ! (cAliasArq)->(EoF())
            cMensagem := "Arquivo " + cArquiAtu + " aberto com sucesso!" + CRLF + CRLF
            cMensagem += "Agora você pode fazer laços de repetição e usar comandos como DbSkip." + CRLF + CRLF
            cMensagem += "Na primeira linha, tem essa informação: " + (cAliasArq)->X3_CAMPO + CRLF
            ShowLog(cMensagem)

        //Senão, avisa que não encontrou informações
        Else
            FWAlertInfo("Não tem dados!", "Arquivo: " + cArquiAtu)
        EndIf
        (cAliasArq)->(DbCloseArea())
    EndIf

    FWRestArea(aArea)
Return
