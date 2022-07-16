/* ===
    Esse é um exemplo disponibilizado no Terminal de Informação
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2022/05/16/validar-se-campo-existe-com-fieldpos-ti-responde-008/
    Caso queira ver outros conteúdos envolvendo AdvPL e TL++, veja em: https://terminaldeinformacao.com/advpl/
=== */

//Bibliotecas
#Include 'Totvs.ch'
 
/*/{Protheus.doc} User Function zVid0008
Função de exemplo demonstrando o uso da FieldPos
@author Atilio
@since 28/01/2022
@version 1.0
@type function
/*/
 
User Function zVid0008()
    Local aArea := GetArea()
    
    DbSelectArea("SB1")

    //Verifica se o campo existe
    If FieldPos("B1_X_CAMPO") > 0
        /* Aqui da para fazer a customização caso o campo exista*/

    Else
        Help(, , 'Atenção - Dicionário', , 'O campo [B1_X_CAMPO] não foi encontrado!', 1, 0, , , , , , {'Contate o Administrador do Sistema'})
    EndIf

    RestArea(aArea)
Return
