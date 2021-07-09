/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/04/20/como-fazer-um-box-com-borda-arredondada-em-fwmsprinter/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "TOTVS.ch"
#Include "RPTDef.ch"
#Include "FWPrintSetup.ch"
 
/*/{Protheus.doc} User Function zCxArren
Função que faz um box / caixa com borda arredondada em um FWMSPrinter
@type  Function
@author Atilio
@since 30/06/2021
@version version
@param oPrint, Object, Objeto instanciado usando a classe FWMSPrinter
@param nLinIni, Numeric, Linha Inicial (Topo)
@param nColIni, Numeric, Coluna Inicial (Esquerda)
@param nLinFin, Numeric, Linha Final (Rodapé)
@param nColFin, Numeric, Coluna Final (Direita)
@example
    u_zCxArren(oPrintPvt, 10, 10, 200, 200)
/*/

User Function zCxArren(oPrint, nLinIni, nColIni, nLinFin, nColFin)
    Local aArea := GetArea()
    Local nLargura  := 0
    Local nAltura   := 0
    Local nLargElip := 0
    Local nAltuElip := 0
    Local nCorBranc := RGB(255, 255, 255)
    Local oBrush    := TBrush():New(, nCorBranc)
    Default nLinIni := 0
    Default nColIni := 0
    Default nLinFin := 0
    Default nColFin := 0

    //Somente se a linha final e coluna final forem maior que linha inicial e coluna inicial
    If nLinFin > nLinIni .And. nColFin > nColIni

        //Calcula a largura e altura do quadro
        nLargura := nColFin - nColIni
        nAltura  := nLinFin - nLinIni

        //Pega 10% como largura e altura do circulo que será criado
        nLargElip := nLargura * 0.1
        nAltuElip := nAltura * 0.1

        //4 circulos um em cada canto
        oPrintPvt:Ellipse(nColIni,             nLinIni,             nLargElip, nAltuElip, nCorBranc) //Circulo no canto superior esquerdo
        oPrintPvt:Ellipse(nColFin - nAltuElip, nLinIni,             nLargElip, nAltuElip, nCorBranc) //Circulo no canto superior direito
        oPrintPvt:Ellipse(nColIni,             nLinFin - nLargElip, nLargElip, nAltuElip, nCorBranc) //Circulo no canto inferior esquerdo
        oPrintPvt:Ellipse(nColFin - nAltuElip, nLinFin - nLargElip, nLargElip, nAltuElip, nCorBranc) //Circulo no canto inferior direito

        //4 linhas ligando os circulos
        oPrintPvt:Line(nLinIni,                 nColIni + (nLargElip/2),       nLinIni,                 nColFin - (nLargElip /2)) //Linha de cima
        oPrintPvt:Line(nLinFin,                 nColIni + (nLargElip/2),       nLinFin,                 nColFin - (nLargElip /2)) //Linha de baixo
        oPrintPvt:Line(nLinIni + (nAltuElip/2), nColIni,                       nLinFin - (nAltuElip/2), nColIni) //Coluna da esquerda
        oPrintPvt:Line(nLinIni + (nAltuElip/2), nColFin,                       nLinFin - (nAltuElip/2), nColFin) //Coluna da direita

        //Faz dois quadros branco para limpar as bordas internas dos circulos
        oPrintPvt:FillRect({nLinIni + 0.5,               nColIni + (nLargElip / 2),   nLinFin - 1.5,               nColFin - (nLargElip / 2)}, oBrush)
        oPrintPvt:FillRect({nLinIni + (nAltuElip / 2), nColIni + 0.5,                 nLinFin - (nAltuElip / 2), nColFin - 1.5},               oBrush)
    EndIf

    RestArea(aArea)
Return
