/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2019/03/27/funcao-para-criar-saldo-inicial-produto/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include "Protheus.ch"
 
/*/{Protheus.doc} zGeraB9
Função que gera saldo inicial
@author Daniel Atilio
@since 16/02/2015
@version 1.0
    @param cCodProd, Caracter, Código do Produto
    @param cArmazem, Caracter, Código do Armazém
    @param nQuant, Numérico, Quantidade do saldo inicial
    @example
    u_zGeraB9("00000001", "01", 3000)
/*/
 
User Function zGeraB9(cCodProd, cArmazem, nQuant)
    Local aArea := GetArea()
     
    DbSelectArea("SB9")
    DbSetOrder(1) //B9_FILIAL+B9_COD+B9_LOCAL+DTOS(B9_DATA)
     
    //Setando valores da rotina automática
    lMsErroAuto := .F.        
    aVetor :={;
        {"B9_FILIAL" ,cFilAnt                          ,Nil},;
        {"B9_COD"    ,cCodProd                       ,Nil},;
        {"B9_LOCAL"  ,cArmazem                          ,Nil},;
        {"B9_DATA"     ,dDataBase                         ,Nil},;
        {"B9_QINI"      ,nQuant                         ,Nil}}
 
    //Iniciando transação e executando saldos iniciais
    Begin Transaction
        MSExecAuto({|x,y| Mata220(x,y)}, aVetor)
         
        //Se houve erro, mostra mensagem
        If lMsErroAuto
            lHouveErro := .T.
            MostraErro()
            DisarmTransaction()
        EndIf
    End Transaction
     
    RestArea(aArea)
Return