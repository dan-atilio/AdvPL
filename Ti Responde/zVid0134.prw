/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/03/18/mudar-a-cor-de-tema-do-protheus-via-codigo-fonte-ti-responde-0134/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

//Variáveis que irão controlar se já ta em execução e o temporizador
Static lEmExec := .F.
Static oTimer

/*/{Protheus.doc} User Function PswSize
Efetua a validação do usuário digitado
@type  Function
@author Atilio
@since 13/02/2024
@see https://tdn.totvs.com/pages/releaseview.action?pageId=6815189
/*/

User Function PswSize()
    Local aRet := PARAMIXB

    //Aciona a função que verifica e modifica as cores do sistema
    //u_zVid0134()

Return aRet

/*/{Protheus.doc} User Function zVid0134
Função que cria o temporizador que vai executar a cada 1 segundo
@type  Function
@author Atilio
@since 13/02/2024
/*/

User Function zVid0134()
    Local nTempo := 1000

    //Se não veio via JOB, aciona a mudança de tema
    If ! IsBlind()

        //Somente se o tema for o Standard (que daí trocamos o AZUL pela outra cor)
        If GetTheme() == "STANDARD"
            //Cria o temporizador e ativa
            oTimer := TTimer():New(;
                nTempo,;
                {|| fColorir() },;
                oMainWnd;
            )
            oTimer:Activate()

            //Aciona pela primeira vez o colorir
            fColorir()
        EndIf
    EndIf
Return

Static Function fColorir()
    Local aArea := GetArea()
    Local nAtual
    Local cCSSOrig
    Local cPasta := "C:\spool\obj\"
    Local aDePara := {}
    //Busca a tela e os objetos dentro dela
    Private nAtuPvt
    Private oPai       := GetWndDefault()
    Private aControles := oPai:aControls

    //Se não estiver em Execução
    If ! lEmExec
        lEmExec := .T.

        //Se a pasta não existir, cria ela
        If ! ExistDir(cPasta)
            MakeDir(cPasta)
        EndIf

        //Adiciona as cores de/para (de OCEAN para VERDE)
        //Tons de Azul na esquerda, tons de Verde na Direita
        aAdd(aDePara, {"0BBAE6", "0CE621"})
        aAdd(aDePara, {"027F9E", "0C9F02"})
        aAdd(aDePara, {"027B99", "027B99"})
        aAdd(aDePara, {"0BBAE6", "0CE60C"})
        aAdd(aDePara, {"027F9E", "0C9F02"})
        aAdd(aDePara, {"027B99", "029A02"})
        aAdd(aDePara, {"3DAFCC", "42CD3D"})
        aAdd(aDePara, {"0D9CBF", "0EC020"})
        aAdd(aDePara, {"369CB5", "37B63F"})
        aAdd(aDePara, {"51DAFC", "57FD52"})
        aAdd(aDePara, {"1188A6", "11A611"})
        aAdd(aDePara, {"4CA0B5", "4DB64D"})
        aAdd(aDePara, {"399CB5", "39B639"})
        aAdd(aDePara, {"0B9BBF", "12C00C"})
        aAdd(aDePara, {"4F545E", "505F52"})
        aAdd(aDePara, {"6B7381", "6C8372"})
        aAdd(aDePara, {"40444C", "434D40"})
        aAdd(aDePara, {"E5EAF2", "E7F3EA"})
        aAdd(aDePara, {"0A728C", "0A8D0F"})
        aAdd(aDePara, {"07657D", "087D0C"})
        aAdd(aDePara, {"31606B", "326C32"})
        aAdd(aDePara, {"09748F", "0D9009"})
        aAdd(aDePara, {"064D5E", "065F1B"})
        aAdd(aDePara, {"041F30", "04300B"})
        aAdd(aDePara, {"2F5265", "306639"})
        aAdd(aDePara, {"09718B", "0D8D09"})
        aAdd(aDePara, {"08667D", "087D17"})
        aAdd(aDePara, {"086880", "08800C"})
        aAdd(aDePara, {"075366", "146607"})
        aAdd(aDePara, {"90A1AB", "90AC91"})
        aAdd(aDePara, {"E0E5EA", "E4ECE3"})

        //Tons em Laranja na Esquerda, Tons em Verde na Direita
        aAdd(aDePara, {"4A2C00", "004A07"})
        aAdd(aDePara, {"FAF2B0", "B2FAAF"})
        aAdd(aDePara, {"EFA018", "18F060"})
        
        //Tons em Cinza, Preto ou Branco, irá manter
        aAdd(aDePara, {"ffffff", "ffffff"})
        aAdd(aDePara, {"FFFFFF", "FFFFFF"})
        aAdd(aDePara, {"000000", "000000"})
        aAdd(aDePara, {"F0F2F5", "F0F2F5"})
        aAdd(aDePara, {"4C4C4C", "4C4C4C"})
        aAdd(aDePara, {"EFF1F4", "EFF1F4"})
        aAdd(aDePara, {"E8ECF0", "E8ECF0"})
        aAdd(aDePara, {"E8ECEF", "E8ECEF"})
        aAdd(aDePara, {"E1E6EB", "E1E6EB"})
        aAdd(aDePara, {"E8EBF1", "E8EBF1"})
        aAdd(aDePara, {"C5C9CA", "C5C9CA"})
        aAdd(aDePara, {"F2F2F2", "F2F2F2"})
        aAdd(aDePara, {"FFF",    "FFF"})
        aAdd(aDePara, {"B2B2B2", "B2B2B2"})
        aAdd(aDePara, {"DEE0DD", "DEE0DD"})
        aAdd(aDePara, {"F1F1F1", "F1F1F1"})
        aAdd(aDePara, {"E4E4E4", "E4E4E4"})
        aAdd(aDePara, {"8B8C91", "8B8C91"})
        aAdd(aDePara, {"AAAAAA", "AAAAAA"})
        aAdd(aDePara, {"F9F9F9", "F9F9F9"})
        aAdd(aDePara, {"FDFDFD", "FDFDFD"})
        aAdd(aDePara, {"383838", "383838"})
        aAdd(aDePara, {"E6E6E6", "E6E6E6"})
        aAdd(aDePara, {"E7E7E7", "E7E7E7"})
        aAdd(aDePara, {"D8D8D8", "D8D8D8"})
        aAdd(aDePara, {"393939", "393939"})
        aAdd(aDePara, {"F3F3F3", "F3F3F3"})
        aAdd(aDePara, {"C5CBCD", "C5CBCD"})
        aAdd(aDePara, {"F9FAFC", "F9FAFC"})
        aAdd(aDePara, {"CACACA", "CACACA"})
        aAdd(aDePara, {"F1F3F2", "F1F3F2"})
        aAdd(aDePara, {"D9D9D9", "D9D9D9"})
        aAdd(aDePara, {"CCCCCC", "CCCCCC"})

        //Percorre todos os objetos da tela
        For nAtual := 1 To Len(aControles)
            nAtuPvt := nAtual

            //Se for um Objeto
            If Type("aControles[nAtuPvt]") == "O"
                //Pega o CSS Original
                cCSSOrig := aControles[nAtual]:GetCSS()

                //Se tiver CSS
                If ! Empty(cCSSOrig)
                    //O CSS Novo, será o original, substituindo as cores conforme o Array De/Para
                    cCSSNovo := cCSSOrig
                    aEval(aDePara, {|x| cCSSNovo := StrTran(cCSSNovo, x[1], x[2])})
                    aControles[nAtual]:SetCSS(cCSSNovo)

                    //Caso você precise trocar outras cores, descomente as linhas abaixo, e depois pelo notepad++ procure na pasta por "#"
                    /*
                    aEval(aDePara, {|x| cCSSOrig := StrTran(cCSSOrig, "#" + x[1], "")})
                    aEval(aDePara, {|x| cCSSOrig := StrTran(cCSSOrig, "#" + x[2], "")})
                    MemoWrite(cPasta + "id_" + cValToChar(nAtual) + ".txt", cCSSOrig)
                    */
                EndIf
            EndIf
        Next

        //Atualiza os objetos da tela
        GetDRefresh()
        lEmExec := .F.
    EndIf

    RestArea(aArea)
Return
