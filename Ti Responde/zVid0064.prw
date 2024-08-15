/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2023/07/10/deixar-um-campo-obrigatorio-via-customizacao-ti-responde-064/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function MA020TDOK
Ponto de Entrada na validação do Fornecedor ao clicar no Confirmar
@type  Function
@author Atilio
@since 01/09/2022
/*/

User Function MA020TDOK()
    Local aArea        := FWGetArea()
    Local lRet         := .T.
    Local cCSSCampo    := "TGet { color: #000000; selection-background-color: #369CB5;    background-color: #fff2f0;     padding-left: 3px;     padding-right: 3px;     border: 1px solid #D3362C;     border-radius: 3px; }tLabel{color: #000000;}"
    Local nAtual       := 0
    //Variáveis de controle dos objetos da tela
    Private oPai       := GetWndDefault()
    Private aControles := oPai:aControls
    Private nAtuPvt    := 0

    //Se o Estado for SP
    If M->A2_EST == "SP"
        //Se não tiver preenchido o email ou a homepage
        If Empty(M->A2_EMAIL) .Or. Empty(M->A2_HPAGE)
            lRet := .F.
            Help(, , "Help", , "Falha ao validar o fornecedor!", 1, 0, , , , , , {"Verifique os campos de eMail e/ou HomePage"})

            //Percorrendo os objetos criados da tela
            For nAtual := 1 To Len(aControles)
                nAtuPvt := nAtual

                //Se tiver variável e descrição
                If Type("aControles[nAtuPvt]:cReadVar") != "U" .And. Type("aControles[nAtuPvt]:cToolTip") != "U"

                    //Somente se tiver conteúdo de TGet
                    If ! Empty(aControles[nAtuPvt]:cReadVar) .And. ! Empty(aControles[nAtuPvt]:cToolTip) .And. 'M->' $ Upper(aControles[nAtuPvt]:cReadVar)
                        
                        //Se for o campo de email e ele estiver vazio -OU- Se for o campo de home page e ele estiver vazio
                        If (Alltrim(aControles[nAtuPvt]:cReadVar) == "M->A2_EMAIL" .And. Empty(M->A2_EMAIL)) .Or. (Alltrim(aControles[nAtuPvt]:cReadVar) == "M->A2_HPAGE" .And. Empty(M->A2_HPAGE))
                            aControles[nAtuPvt]:SetCSS(cCSSCampo)
                        EndIf
                        
                    EndIf
                EndIf
            Next


        EndIf
    EndIf

    FWRestArea(aArea)
Return lRet
