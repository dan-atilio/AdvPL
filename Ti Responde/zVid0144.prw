/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/04/22/adicionar-validacao-de-email-nos-campos-ti-responde-0144/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVldMail
Função que valida se o campo digitado possui emails válidos
@type  Function
@author Atilio
@since 12/04/2024
@obs Após compilar, coloque na validação de usuário (X3_VLDUSER) dos campos desejados como o A1_EMAIL: u_zVldMail()

Abaixo alguns exemplos que você pode testar:
"teste@teste.com"
"teste@teste.com;"
"teste@teste.com;teste2@tst.com"
"teste@teste.com;teste2@tst"
"teste@te ste.com"
";;;"
"aaa"
/*/

User Function zVldMail()
    Local aArea     := FWGetArea()
    Local lContinua := .T.
    Local cEmails   := Alltrim(&(ReadVar()))
    Local aEmails   := {}
    Local nAtual    := 0

    //Se tiver ponto e vírgula
    If ";" $ cEmails
        //Valida se o usuário só colocou ;, para assim impedir
        If Empty(StrTran(cEmails, ";", ""))
            lContinua := .F.
            ExibeHelp("Help zVldMail", "eMail inválido!", "Verifique se foi inserido corretamente o campo!")
        Else

            //Quebra a string em um array
            aEmails := StrTokArr(cEmails, ";")

            //Percorre todos os eMails enocntrados
            For nAtual := 1 To Len(aEmails)

                //Só vai continuar se o email for válido
                lContinua := lContinua .And. IsEmail(aEmails[nAtual])

                //Se houve alguma falha, já encerra o laço
                If ! lContinua
                    Exit
                EndIf

            Next
        EndIf


    //Senão, valida só o que foi inserido no campo
    Else
        lContinua := IsEmail(cEmails)
    EndIf

    FWRestArea(aArea)
Return lContinua
