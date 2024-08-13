/*
    Esse exemplo faz parte da série do YouTube, Maratona de Exemplos, do canal Terminal de Informação, 
    caso queira ver esse exemplo rodando em vídeo, acesse o seguinte link:     https://terminaldeinformacao.com/2024/04/16/imprimindo-etiqueta-em-impressora-termica-com-mscbprinter-maratona-advpl-e-tl-358/
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zExe359
Abre a tela de banco de conhecimento
@type Function
@author Atilio
@since 26/03/2023
@see https://tdn.totvs.com/display/public/framework/MsDocument
@obs 
    Função MsDocument
    Parâmetros
        Alias da Tabela
        Número do Registro (Recno)
        Opção do menu (4 = alteração; 2 = visualização;)
    Retorno
        Retorno lógico se conseguiu abrir a tela ou não

    **** Apoie nosso projeto, se inscreva em https://www.youtube.com/TerminalDeInformacao ****
/*/

User Function zExe359()
    Local aArea      := FWGetArea()
    Local cCodigo    := "C00001"
    Local cLoja      := "01"

    //Abre a tabela de clientes
    DbSelectArea("SA1")
    SA1->(DbSetOrder(1)) // Filial + Código + Loja

    //Se conseguir posicionar no cliente, abre o banco de conhecimento dele
    If SA1->(MsSeek(FWxFilial('SA1') + cCodigo + cLoja))
        MsDocument('SA1', SA1->(RecNo()), 4)
    EndIf

    FWRestArea(aArea)
Return
