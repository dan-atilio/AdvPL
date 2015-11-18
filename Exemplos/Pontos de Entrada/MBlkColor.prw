//Bibliotecas
#Include "Protheus.ch"

//Constantes
#Define CLR_RGB_BRANCO		RGB(254,254,254)	//Cor Branca em RGB
#Define CLR_RGB_VERMELHO		RGB(255,000,000)	//Cor Vermelha em RGB
#Define CLR_RGB_PRETO		RGB(000,000,000)	//Cor Preta em RGB

/*------------------------------------------------------------------------------------------------------*
 | P.E.:  MBlkColor                                                                                     |
 | Autor: Daniel Atilio                                                                                 |
 | Data:  26/08/2014                                                                                    |
 | Desc:  Altera a cor da linha bloqueada                                                               |
 | Links: http://tdn.totvs.com/display/public/mp/MBlkColor+-+Retorna+cores+a+utilizar                   |
 |        http://tdn.totvs.com/display/public/mp/Campo+Reservado+_MSBLQD+e+_MSBLQL                      |
 *------------------------------------------------------------------------------------------------------*/

User Function MBlkColor()
	Local aRet := {}	//Se deixar assim tem o retorno padrão

	//Adicionando as cores
	aAdd(aRet, (CLR_RGB_PRETO)   ) //Cor do texto
	aAdd(aRet, (CLR_RGB_VERMELHO)) //Cor de fundo

Return aRet