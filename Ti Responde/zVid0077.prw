/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2024/08/29/como-ver-quais-sao-os-atalhos-em-memoria-ti-responde-0077/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function ChkExec
Ponto de entrada, ao abrir alguma rotina no menu
@type  Function
@author Atilio
@since 30/11/2023
@see @see https://tdn.totvs.com/display/public/framework/CHKEXEC+-+Dispara+ponto+de+entrada
/*/

User Function ChkExec()
    Local aArea    := FWGetArea()
    
    //Adiciona um atalho para verificar os atalhos principais em memória
    SetKey(K_SH_F5, {|| u_zVid0077() })

    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function zVid0077
Função que abre uma tela com os principais atalhos configurados
@type  Function
@author Atilio
@since 30/11/2023
/*/

User Function zVid0077()
    Local aArea := FWGetArea()
    Local cTexto := ""
    Local cExibir := ""
    Local nKeyF
    Local cAtalhoKey
    Local aAtalhos := {}
    Local bKeyF
    Local cDescricao := ""
    Local nAtalho

    //Adiciona as teclas de atalho que serão verificadas
    //Caso queira adicionar outros, aqui tem a lista de atalhos possíveis - https://tdn.totvs.com/display/tec/SetKey
    aAdd(aAtalhos, {"F1",  VK_F1})
    aAdd(aAtalhos, {"F2",  VK_F2})
    //aAdd(aAtalhos, {"F3",  VK_F3})
    aAdd(aAtalhos, {"F4",  VK_F4})
    aAdd(aAtalhos, {"F5",  VK_F5})
    aAdd(aAtalhos, {"F6",  VK_F6})
    aAdd(aAtalhos, {"F7",  VK_F7})
    aAdd(aAtalhos, {"F8",  VK_F8})
    aAdd(aAtalhos, {"F9",  VK_F9})
    aAdd(aAtalhos, {"F10", VK_F10})
    aAdd(aAtalhos, {"F11", VK_F11})
    aAdd(aAtalhos, {"F12", VK_F12})

    //Aqui vamos adicionar também as funções do Canivete de Atalhos ( https://terminaldeinformacao.com/2022/05/30/canivete-suico-de-atalhos-uteis-ti-responde-009/ )
    //E a própria função dos atalhos (Shift F5)
    aAdd(aAtalhos, {"Ctrl + L",    K_CTRL_L})
    aAdd(aAtalhos, {"Shift + F5",  K_SH_F5})
    aAdd(aAtalhos, {"Shift + F7",  K_SH_F7})
    aAdd(aAtalhos, {"Shift + F8",  K_SH_F8})
    aAdd(aAtalhos, {"Shift + F9",  K_SH_F9})
    aAdd(aAtalhos, {"Shift + F11", K_SH_F11})

    //Percorre as teclas
    For nKeyF := 1 To Len(aAtalhos)
        cDescricao := PadR(aAtalhos[nKeyF][1], 12)
        nAtalho    := aAtalhos[nKeyF][2]

        //Busca o bloco de código
        bKeyF := &("SetKey(" + cValToChar(nAtalho) + ")")

        //Se o bloco de código existir
        If ValType(bKeyF) == "B"
            //Transforma o bloco de código em caractere
            cAtalhoKey := GetCBSource(bKeyF)

            //Incrementa a mensagem
            cTexto += "+ " + cDescricao + ": " + cAtalhoKey + CRLF

            //Volta o atalho para a memória
            SetKey(nAtalho, bKeyF)
        EndIf
    Next

    //Se houver texto
    If ! Empty(cTexto)
        cExibir := "Função:    " + FunName() + CRLF
        cExibir += "Descrição: " + FunDesc() + CRLF
        cExibir += CRLF + CRLF
        cExibir += "Atalhos na Memória: " + CRLF + CRLF
        cExibir += cTexto

        ShowLog(cExibir)
    EndIf

    FWRestArea(aArea)
Return
