/*
    
    Esse é um exemplo disponibilizado no Terminal de Informação 
    Confira o artigo sobre esse assunto, no seguinte link: https://terminaldeinformacao.com/2025/04/03/como-usar-a-eval-para-somar-valores-ti-responde-0139/ 
    
*/


//Bibliotecas
#Include "TOTVS.ch"

/*/{Protheus.doc} User Function zVid0139
Demonstração de utilização da eVal para executar blocos de código
@type  Function
@author Atilio
@since 29/03/2024
@see https://tdn.totvs.com/display/tec/Eval
/*/

User Function zVid0139()
    Local aArea     := FWGetArea()

    //Primeiro declaramos a variável de saldo, e depois o bloco de código, que vai atualizar a saldo com o valor recebido
    Local nSaldo    := 0
    Local bBlocoCod := {|nValor| nSaldo := nSaldo + nValor}

    //Depois passamos 3 valores, 5 com 6 com 3 (vai dar 14 o resultado)
    eVal(bBlocoCod, 5)
    eVal(bBlocoCod, 6)
    eVal(bBlocoCod, 3)

    //Por fim, mostramos uma mensagem
    FWAlertSuccess("Resultado é: " + cValToChar(nSaldo), "Sucesso")

    FWRestArea(aArea)
Return
